//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
//
// class HistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Color(0xFF4C2659),
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.05, // Adjust position as needed
//             left: 15,
//             right: 0,
//             child: Text(
//               'History',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.purple.shade100,
//               ),
//             ),
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.10,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child:StreamBuilder<User?>(
//                 stream: FirebaseAuth.instance.authStateChanges(),
//                 builder: (context, userSnapshot) {
//                   if (userSnapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (userSnapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${userSnapshot.error}'),
//                     );
//                   }
//                   if (userSnapshot.data == null) {
//                     return Center(
//                       child: Text('User not authenticated.'),
//                     );
//                   }
//                   final String userId = userSnapshot.data!.uid;
//                   return StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance.collection('users').doc(userId).collection('sms_history').snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text('Error: ${snapshot.error}'),
//                         );
//                       }
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         return Center(
//                           child: Text('No SMS history available.'),
//                         );
//                       }
//                       return ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           DocumentSnapshot sms = snapshot.data!.docs[index];
//                           return Card(
//                             color: Colors.purple.shade50,
//                             margin: EdgeInsets.only(left: 18,right: 18,bottom: 15),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(14),
//                                     child: Container(
//                                       height: 150,
//                                       width: 150,
//                                       child: GoogleMap(
//                                         trafficEnabled: true,
//                                         initialCameraPosition: CameraPosition(
//                                           target: LatLng(
//                                             sms['location'].latitude,
//                                             sms['location'].longitude,
//                                           ),
//                                           zoom: 15.0,
//                                         ),
//                                         markers: {
//                                           Marker(
//                                             markerId: MarkerId('current_location_$index'),
//                                             position: LatLng(
//                                               sms['location'].latitude,
//                                               sms['location'].longitude,
//                                             ),
//                                           ),
//                                         },
//                                         myLocationEnabled: false,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 65),
//                                     child: Center(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           FutureBuilder<String>(
//                                             future: _getPlaceName(sms['location'].latitude, sms['location'].longitude),
//                                             builder: (context, placeSnapshot) {
//                                               if (placeSnapshot.connectionState == ConnectionState.waiting) {
//                                                 return CircularProgressIndicator();
//                                               }
//                                               if (placeSnapshot.hasError) {
//                                                 return Text('Error fetching place name');
//                                               }
//                                               return Text(
//                                                 'Place: ${placeSnapshot.data}',
//                                                 style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
//                                               );
//                                             },
//                                           ),
//                                           Text(
//                                             'Sent to: ${sms['sentTo'].join(', ')}\nSent at: ${_formatDateTime(sms['sentAt'].toDate())}',
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//
//
//
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//
//     );
//   }
//
//   Future<String> _getPlaceName(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//       Placemark place = placemarks[0];
//       String location = place.locality ?? '';
//       if (place.subLocality != null && place.subLocality!.isNotEmpty) {
//         location += ', ' + place.subLocality!;
//       }
//       if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
//         location += ', ' + place.thoroughfare!;
//       }
//       return location;
//     } catch (e) {
//       print('Error getting place name: $e');
//       return 'Unknown';
//     }
//   }
//
//   String _formatDateTime(DateTime dateTime) {
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
//   }
// }
//
//



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF4C2659),
            width: double.infinity,
            height: screenSize.height,
          ),
          Positioned(
            top: screenSize.height * 0.05,
            left: screenSize.width * 0.05,
            child: Text(
              'History',
              style: TextStyle(
                fontSize: screenSize.width * 0.06,
                color: Colors.purple.shade100,
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenSize.width * 0.04),
                  topRight: Radius.circular(screenSize.width * 0.04),
                ),
              ),
              width: screenSize.width,
              height: screenSize.height * 0.9,
              child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (userSnapshot.hasError) {
                    return Center(
                      child: Text('Error: ${userSnapshot.error}'),
                    );
                  }
                  if (userSnapshot.data == null) {
                    return Center(
                      child: Text('User not authenticated.'),
                    );
                  }
                  final String userId = userSnapshot.data!.uid;
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('history').doc(userId).collection('sms_history').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('No SMS history available.'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot sms = snapshot.data!.docs[index];
                          return Card(
                            color: Colors.purple.shade50,
                            margin: EdgeInsets.only(
                              left: screenSize.width * 0.04,
                              right: screenSize.width * 0.04,
                              bottom: screenSize.height * 0.015,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(screenSize.width * 0.01),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(screenSize.width * 0.05),
                                      child: Container(
                                        height: screenSize.height * 0.18,
                                        width: screenSize.width * 0.4,
                                        child: GoogleMap(
                                          trafficEnabled: true,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                              sms['location'].latitude,
                                              sms['location'].longitude,
                                            ),
                                            zoom: 15.0,
                                          ),
                                          markers: {
                                            Marker(
                                              markerId: MarkerId('current_location_$index'),
                                              position: LatLng(
                                                sms['location'].latitude,
                                                sms['location'].longitude,
                                              ),
                                            ),
                                          },
                                          myLocationEnabled: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.065),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FutureBuilder<String>(
                                            future: _getPlaceName(sms['location'].latitude, sms['location'].longitude),
                                            builder: (context, placeSnapshot) {
                                              if (placeSnapshot.connectionState == ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }
                                              if (placeSnapshot.hasError) {
                                                return Text('Error fetching place name');
                                              }
                                              return Text(
                                                'Place: ${placeSnapshot.data}',
                                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                                              );
                                            },
                                          ),
                                          Text(
                                            'Sent to: ${sms['sentTo'].join(', ')}\nSent at: ${_formatDateTime(sms['sentAt'].toDate())}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getPlaceName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
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
      return 'Unknown';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
