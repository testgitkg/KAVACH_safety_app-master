
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:direct_sms/direct_sms.dart';
import 'package:kavach_project/presentation/profile_screen/profile_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shake/shake.dart'; // Import the shake package
import 'package:shared_preferences/shared_preferences.dart';
import '../Fake_call/fale_call_details.dart';
import '../National_helpline_screen/National_helpline_screen.dart';
import '../SOS/sos.dart';
import '../Voice_detection/voice_detection.dart';
import '../drawer_screen/drawer_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print("Error signing in anonymously: $e");
      return null;
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}

class ContactManager {
  final CollectionReference contactCollection =
  FirebaseFirestore.instance.collection('contacts');
  final CollectionReference smsCollection =
  FirebaseFirestore.instance.collection('sms_history');

  Future<void> sendLiveLocationToSelectedContacts(BuildContext context) async {
    try {
      bool isSmsLimitExceeded = await _checkSmsLimitExceeded();
      if (isSmsLimitExceeded) {
        _showSmsLimitExceededAlert(context); // Show alert if limit exceeded
        return;
      }

      Position? position = await _getCurrentLocation();
      if (position != null) {
        String userId = AuthService().getCurrentUser()?.uid ?? '';
        if (userId.isNotEmpty) {
          DocumentSnapshot contactSnapshot =
          await contactCollection.doc(userId).get();

          if (contactSnapshot.exists) {
            List<Map<String, dynamic>> contacts = [];
            if (contactSnapshot.exists) {
              Map<String, dynamic>? data =
              contactSnapshot.data() as Map<String, dynamic>?;
              if (data != null && data.containsKey("contacts")) {
                contacts = List<Map<String, dynamic>>.from(data["contacts"] ?? []);
              }
            }

            List<String> phoneNumbers = contacts
                .map((contact) => contact['phoneNumber'] as String)
                .toList();

            String message =
                'I am in trouble. Please help me. My current location is: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

            await _sendSMSBatch(
                phoneNumbers, message, position.latitude, position.longitude);

            await _incrementSmsCount();
          }
        }
      }
    } catch (e) {
      print("Error sending live location to selected contacts: $e");
    }
  }

  Future<bool> _checkSmsLimitExceeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = AuthService().getCurrentUser()?.uid ?? '';
    DateTime now = DateTime.now();

    // Check if user preferences exist
    if (!prefs.containsKey(userId)) {
      // If user preferences don't exist, initialize with default values
      prefs.setString(userId, jsonEncode({'smsCount': 0, 'lastSentDate': now.toString()}));
    }

    // Get user preferences
    Map<String, dynamic> userData = jsonDecode(prefs.getString(userId) ?? '{}');
    int smsCount = userData['smsCount'] ?? 0;
    DateTime lastSentDate = DateTime.parse(userData['lastSentDate'] ?? now.toString());

    // Check if it's a new day
    if (now.year != lastSentDate.year || now.month != lastSentDate.month || now.day != lastSentDate.day) {
      // Reset count if it's a new day
      smsCount = 0;
    }

    return smsCount >= 8;
  }

  Future<void> _incrementSmsCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = AuthService().getCurrentUser()?.uid ?? '';

    // Get user preferences
    Map<String, dynamic> userData = jsonDecode(prefs.getString(userId) ?? '{}');
    int smsCount = userData['smsCount'] ?? 0;

    // Increment count
    smsCount = smsCount + 1;

    // Update user preferences
    userData['smsCount'] = smsCount;
    userData['lastSentDate'] = DateTime.now().toString();
    prefs.setString(userId, jsonEncode(userData));
  }



  void _showSmsLimitExceededAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('SMS Limit Exceeded'),
        content: Text('You have reached the maximum limit of 7 SMS for today.'),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4C2559),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
              ),
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.30,
                MediaQuery.of(context).size.height * 0.06,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }

  Future<void> _sendSMSBatch(List<String> phoneNumbers, String message, double latitude, double longitude) async {
    try {
      final DirectSms directSms = DirectSms();
      for (final phoneNumber in phoneNumbers) {
        directSms.sendSms(phone: phoneNumber, message: message);
      }
      print('SMS sent to recipients: $phoneNumbers');

      // Get current user ID
      String userId = AuthService().getCurrentUser()?.uid ?? '';

      if (userId.isNotEmpty) {
        // Get current timestamp
        DateTime currentTime = DateTime.now();

        // Get place name from latitude and longitude
        String placeName = await _getPlaceName(latitude, longitude);

        // Store SMS details in Firestore within user's document
        await FirebaseFirestore.instance.collection('history').doc(userId).collection('sms_history').add({
          'message': message,
          'sentTo': phoneNumbers,
          'sentAt': Timestamp.fromDate(currentTime),
          'location': GeoPoint(latitude, longitude),
          'placeName': placeName,
        });
        print('SMS details stored in Firestore for user: $userId');
      } else {
        print('User ID is empty. Cannot store SMS details.');
      }
    } catch (e) {
      print('Error sending SMS batch: $e');
    }
  }

  Future<String> _getPlaceName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      // Extract the desired location information, such as locality, subLocality, or thoroughfare
      String location = place.locality ?? '';
      if (place.subLocality != null && place.subLocality!.isNotEmpty) {
        location += ', ' + place.subLocality!;
      }
      if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
        location += ', ' + place.thoroughfare!;
      }
      return location;
    } catch (e) {
      print('Error getting place name: $e');
      return '';
    }
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  GoogleMapController? _controller;
  LatLng _currentLocation = LatLng(0, 0);
  late ShakeDetector detector; // Declare ShakeDetector variable
  bool _messageSent = false;
  int _shakeCount = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startShakeDetection();

    // Initialize ShakeDetector
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      if (!_messageSent && _shakeCount < 3) {
        _shakeCount++;
      } else if (!_messageSent && _shakeCount == 3) {
        _messageSent = true;
        ContactManager().sendLiveLocationToSelectedContacts(context).then((_) {
          // Reset _messageSent after sending SMS
          _messageSent = false;
          _shakeCount = 0; // Reset shake count
        }).catchError((error) {
          print("Error sending SMS: $error");
          // Handle error, reset _messageSent in case of failure too
          _messageSent = false;
          _shakeCount = 0; // Reset shake count
        });
      }
    });
  }

  @override
  void dispose() {
    _stopShakeDetection();
    detector.stopListening(); // Stop ShakeDetector when disposing
    super.dispose();
  }

  void _startShakeDetection() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      final double shakeThreshold = 20; // Adjust as needed
      final now = DateTime.now();
      if (_lastEvent != null) {
        final deltaTime = now.difference(_lastTime).inMilliseconds;
        final deltaX = (_lastEvent!.x - event.x).abs();
        final deltaY = (_lastEvent!.y - event.y).abs();
        final deltaZ = (_lastEvent!.z - event.z).abs();

        // Calculate total delta
        final totalDelta = deltaX + deltaY + deltaZ;

        // Check if shake exceeds threshold and if message hasn't been sent already
        if (totalDelta > shakeThreshold && deltaTime > 1000 && !_messageSent) {
          _lastTime = now;
          if (_shakeCount < 3) {
            _shakeCount++;
          } else if (_shakeCount == 3) {
            _messageSent = true; // Set message sent flag
            ContactManager().sendLiveLocationToSelectedContacts(context).then((_) {
              // Reset _messageSent after sending SMS
              _messageSent = false;
              _shakeCount = 0; // Reset shake count
            }).catchError((error) {
              print("Error sending SMS: $error");
              // Handle error, reset _messageSent in case of failure too
              _messageSent = false;
              _shakeCount = 0; // Reset shake count
            });
          }
        }
      }
      _lastEvent = event;
    });
  }


  void _stopShakeDetection() {
    // Optionally, stop listening to accelerometer events when not needed
    accelerometerEvents.drain();
  }

  AccelerometerEvent? _lastEvent;
  DateTime _lastTime = DateTime.now();

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      if (_controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLng(_currentLocation));
      }
    } catch (e) {
      print(e);
    }
  }

  // void _onTrackMePressed() {
  //   if (!_messageSent) {
  //     _messageSent = true;
  //     ContactManager().sendLiveLocationToSelectedContacts(context).then((_) {
  //       // Reset _messageSent after sending SMS
  //       _messageSent = false;
  //     }).catchError((error) {
  //       print("Error sending SMS: $error");
  //       // Handle error, reset _messageSent in case of failure too
  //       _messageSent = false;
  //     });
  //   }
  // }


  void _onTrackMePressed() async {
    if (!_messageSent) {
      // Check if the user has selected any SOS contact
      bool hasSOSContacts = await _checkSOSContacts();
      if (hasSOSContacts) {
        _messageSent = true;
        ContactManager().sendLiveLocationToSelectedContacts(context).then((_) {
          // Reset _messageSent after sending SMS
          _messageSent = false;
        }).catchError((error) {
          print("Error sending SMS: $error");
          // Handle error, reset _messageSent in case of failure too
          _messageSent = false;
        });
      } else {
        // Show alert if no SOS contacts are selected
        _showNoSOSContactsAlert(context);
      }
    }
  }

  Future<bool> _checkSOSContacts() async {
    String userId = AuthService().getCurrentUser()?.uid ?? '';
    if (userId.isNotEmpty) {
      DocumentSnapshot contactSnapshot = await FirebaseFirestore.instance.collection('contacts').doc(userId).get();
      if (contactSnapshot.exists) {
        Map<String, dynamic>? data = contactSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("contacts")) {
          List<Map<String, dynamic>> contacts = List<Map<String, dynamic>>.from(data["contacts"] ?? []);
          return contacts.isNotEmpty;
        }
      }
    }
    return false;
  }

  void _showNoSOSContactsAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No SOS Contacts Selected'),
        content: Text('Please add SOS contacts from the SOS contacts to use this feature.'),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4C2559),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
              ),
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.30,
                MediaQuery.of(context).size.height * 0.06,
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/log6.png',
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      width: screenWidth * 0.21,
                      height: screenWidth * 0.22,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.297, top: 1),
                    child: Text(
                      "kavach",
                      style: TextStyle(
                        fontFamily: 'kalam',
                        fontSize: screenWidth * 0.063,
                        color: Color(0xFF4C2559),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.menu, size: screenWidth * 0.077),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Drawerscreen()));
                    },
                  ),
                ],
              ),
              Divider(
                thickness: screenWidth * 0.011,
                color: Colors.grey.shade100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.00),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.067,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.purple.shade50],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.046),
                        child: Container(
                          child: Text(
                            "Track Me",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4C2559),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.046),
                        child: Text(
                          "Share your live location with your SOS contact",
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF4C2559),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.707,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _currentLocation,
                        zoom: 15.0,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: _currentLocation == null
                          ? {}
                          : {
                        Marker(
                          markerId: MarkerId("current_location"),
                          position: _currentLocation,
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
            width: 120, // Adjust width as needed
            child: ElevatedButton(
              onPressed: (){
                _onTrackMePressed();
                _getCurrentLocation();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xFF4C2559), // Change color as needed
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Track Me",
                  style: TextStyle(
                    fontSize: 14, // Adjust font size as needed
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // Your bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: CupertinoButton(
                onPressed: (){
                 // _getCurrentLocation();
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>FakeCallDetails()));

                },
                child: Icon(CupertinoIcons.phone_circle, color: Color(0xFF4C2559)),
              ),
              label: 'Fake Call'
          ),
          BottomNavigationBarItem(
            icon: CupertinoButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SOSPage()));
                // Placeholder action for voice button
              },
              child: Icon(CupertinoIcons.mic, color: Color(0xFF4C2559)),
            ),
            label: 'Voice',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CountdownPage()));
                // Placeholder action for SOS button
              },
              child: Container(
                width: screenWidth * 0.1147,
                height: screenHeight * 0.0657,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Image(image: AssetImage("assets/sos_4617104.png")),
              ),
            ),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: CupertinoButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Helpline()));
                // Placeholder action for helpline button
              },
              child: Icon(CupertinoIcons.phone_badge_plus, color: Color(0xFF4C2559)),
            ),
            label: 'Helpline',
          ),
          BottomNavigationBarItem(
            icon: CupertinoButton(
              onPressed: () async {
                try{
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  final User user = _auth.currentUser!;

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen(
                      user: user
                  )));
                }catch(e){
                  print(e);
                }
              },
              // onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(user: user)));
              // },
              child: Icon(CupertinoIcons.person, color: Color(0xFF4C2559)),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4C2559),
        unselectedLabelStyle: TextStyle(color: Color(0xFF4C2559)),
        // onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

