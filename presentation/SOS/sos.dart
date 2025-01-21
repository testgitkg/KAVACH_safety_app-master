import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direct_sms/direct_sms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kavach_project/presentation/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        await FirebaseFirestore.instance.collection('users').doc(userId).collection('sms_history').add({
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountdownPage(),
    );
  }
}

class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _timer;
  int _start = 3;
  bool _smsSent = false; // Track whether SMS has been sent

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          if (!_smsSent) {
            _smsSent = true; // Mark SMS as sent
            ContactManager().sendLiveLocationToSelectedContacts(context);
            _showToast('Live location shared with SOS contacts'); // Display toast message
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showToast(String message) {
    if (!_smsSent) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _start.toString(),
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    minimumSize: Size(180, 60),
                  ),
                  onPressed: () {
                    _timer.cancel();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel SOS'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(180, 60),
                  ),
                  onPressed: () {},
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
