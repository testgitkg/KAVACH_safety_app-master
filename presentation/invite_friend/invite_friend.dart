// import 'package:flutter/material.dart';
// import 'package:kavach_project/presentation/invite_friend/provider/invite_friend_provider.dart';
// import '../../core/app_export.dart';
// import '../contactlist.dart';
//
//
// class Addfriend extends StatelessWidget {
//   final numcontroller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: screenWidth * 0.98,
//               height: screenHeight * 0.98,
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(color: Colors.white),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     top: -15,
//                     child: Container(
//                       width: screenWidth * 0.98,
//                       height: screenHeight * 0.4,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: screenHeight * 0.1 - 4,
//                             child: Container(
//                               width: screenWidth * 0.98,
//                               decoration: ShapeDecoration(
//                                 shape: RoundedRectangleBorder(
//                                   side: BorderSide(
//                                     width: 2.50,
//                                     color: Colors.grey.shade100,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: screenWidth * 0.16,
//                             top: screenHeight * 0.016,
//                             child: Container(
//                               width: screenWidth * 0.76,
//                               height: screenHeight * 0.065,
//                               decoration: BoxDecoration(color: Colors.white),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: screenHeight * 0.016,
//                             child: Container(
//                               width: screenWidth * 0.87,
//                               height: screenHeight * 0.065,
//                               decoration: BoxDecoration(color: Color(0xFFFFFDFD)),
//                             ),
//                           ),
//                           Positioned(
//                             left: screenWidth * 0.27,
//                             top: screenHeight * 0.052,
//                             child: SizedBox(
//                               width: screenWidth * 0.18,
//                               height: screenHeight * 0.025,
//                               child: Text(
//                                 'Kavach',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Color(0xFF5C343E),
//                                   fontSize: screenHeight * 0.025,
//                                   fontFamily: 'Arial',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: screenWidth * 0.035,
//                             top: screenHeight * 0.049,
//                             child: Container(
//                               width: screenWidth * 0.07,
//                               height: screenWidth * 0.07,
//                               child: InkWell(
//                                   onTap: (){
//                                     Navigator.pop(context);
//                                   },
//                                   child: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF4C2559))),
//                             ),
//                           ),
//                           Positioned(
//                             left: screenWidth * 0.085,
//                             top: screenHeight * 0.018,
//                             child: Container(
//                               width: screenWidth * 0.21,
//                               height: screenWidth * 0.21,
//                               decoration: ShapeDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage("assets/log6.png"),
//                                   fit: BoxFit.fill,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(screenWidth * 0.14 / 2),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.35,
//                     top: screenHeight * 0.11,
//                     child: Text(
//                       'Add Friend',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Color(0xFF683F72),
//                         fontSize: screenHeight * 0.027,
//                         fontFamily: 'Arial',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: screenHeight * 0.27, left: screenWidth * 0.06, right: screenWidth * 0.20),
//                     child: TextFormField(
//                       style: TextStyle(height: 1),
//                       controller: numcontroller,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(screenWidth * 0.04),
//                           // borderSide: BorderSide(color: Colors.red, width: 2.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.purple.shade100, width: 2.0),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.03),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.82,
//                     top: screenHeight * 0.27,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSearch()));
//                       },
//                       child: Container(
//                         width: screenWidth * 0.12,
//                         height: screenWidth * 0.12,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Image(image: AssetImage("assets/contact-book.png")),
//                         ),
//                         decoration: ShapeDecoration(
//                           color: Color(0xFFFBF2FB),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(width: 1, color: Color(0xFFD8BEE1)),
//                             borderRadius: BorderRadius.circular(screenWidth * 0.03),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.10,
//                     top: screenHeight * 0.36,
//                     child: SizedBox(
//                       width: screenWidth * 0.70,
//                       child: Text(
//                         'Make this person my SOS contact',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF683F72),
//                           fontSize: 14,
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.06,
//                     top: screenHeight * 0.355,
//                     child: Container(
//                       width: screenWidth * 0.055,
//                       height: screenHeight * 0.036,
//                       child: Icon(Icons.star, color: Color(0xFF4C2559), size: screenHeight * 0.023),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.06,
//                     right: screenWidth * 0.05,
//                     top: screenHeight * 0.413,
//                     child: Container(
//                       width: screenWidth * 0.8,
//                       height: screenHeight * 0.22,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFFBF2FB),
//                         shape: RoundedRectangleBorder(
//                           side: BorderSide(width: 1, color: Color(0xFFA68CAF)),
//                           borderRadius: BorderRadius.circular(screenWidth * 0.027),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 45,
//                     top: screenHeight * 0.45,
//                     child: Container(
//                       width: screenWidth * 0.065,
//                       height: screenWidth * 0.065,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/multiple-users-silhouette.png"),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.412,
//                     top: screenHeight * 0.15,
//                     child: Container(
//                       width: screenWidth * 0.15,
//                       height: screenWidth * 0.15,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/multiple-users-silhouette.png"),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.09,
//                     top: screenHeight * 0.428,
//                     child: SizedBox(
//                       width: screenWidth * 0.4,
//                       child: Text(
//                         'Friend',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF683F72),
//                           fontSize: screenHeight * 0.022,
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 55,
//                     top: screenHeight * 0.535,
//                     child: SizedBox(
//                       width: screenWidth * 0.412,
//                       child: Text(
//                         'SOS Contact',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF683F72),
//                           fontSize: screenHeight * 0.018,
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 85,
//                     top: screenHeight * 0.46,
//                     child: SizedBox(
//                       width: screenWidth * 0.658,
//                       child: Text(
//                         'You can share your live location with your friends using the track me feature.',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 91,
//                     top: screenHeight * 0.56,
//                     child: SizedBox(
//                       width: screenWidth * 0.712,
//                       child: Text(
//                         'You can send SOS alerts only to the SOS contacts durings on emergency.',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: screenWidth * 0.07,
//                     top: screenHeight * 0.6,
//                     child: Container(width: screenWidth * 0.1, height: screenWidth * 0.09),
//                   ),
//                   Positioned(
//                     left: 45,
//                     top: screenHeight * 0.55,
//                     child: Container(
//                       width: screenWidth * 0.070,
//                       height: screenWidth * 0.070,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("assets/sos.png"),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Positioned(
//                     top: screenHeight * 0.76,
//                     left: screenWidth * 0.19,
//                     child: Stack(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Access the FriendProvider
//                             final friendProvider = Provider.of<FriendProvider>(context, listen: false);
//
//                             // Add the friend to the provider
//                             // friendProvider.addFriend(
//                             //   // FriendModel(
//                             //   //   name: 'Friend Name', // Replace with actual name
//                             //   //   phoneNumber: '1234567890', // Replace with actual phone number
//                             //   // ),
//                             // );
//
//                             // Navigate to ContactSearch widget
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSearch()));
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF4C2559),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(screenWidth * 0.04),
//                             ),
//                             minimumSize: Size(
//                               screenWidth * 0.60,
//                               screenHeight * 0.06,
//                             ),
//                           ),
//                           child: Text(
//                             "Add SOS Contact",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: screenHeight * 0.018,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../contactlist.dart';

class Addfriend extends StatefulWidget {
  const Addfriend({Key? key}) : super(key: key);

  @override
  State<Addfriend> createState() => _AddfriendState();
}

class _AddfriendState extends State<Addfriend> {
  final numcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.98,
              height: screenHeight * 0.98,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: -15,
                    child: Container(
                      width: screenWidth * 0.98,
                      height: screenHeight * 0.4,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: screenHeight * 0.2 - 72,
                            child: Container(
                              width: screenWidth * 0.98,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2.50,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.16,
                            top: screenHeight * 0.016,
                            child: Container(
                              width: screenWidth * 0.76,
                              height: screenHeight * 0.065,
                              decoration: BoxDecoration(color: Colors.white),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: screenHeight * 0.016,
                            child: Container(
                              width: screenWidth * 0.87,
                              height: screenHeight * 0.065,
                              decoration: BoxDecoration(color: Color(0xFFFFFDFD)),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.23,
                            top: screenHeight * 0.068,
                            child: SizedBox(
                              width: screenWidth * 0.25,
                              height: screenHeight * 0.029,
                              child: Text(
                                'Kavach',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5C343E),
                                  fontSize: screenHeight * 0.029,
                                  fontFamily: 'kalam',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.035,
                            top: screenHeight * 0.068,
                            child: Container(
                              width: screenWidth * 0.07,
                              height: screenWidth * 0.07,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xFF4C2559))),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.085,
                            top: screenHeight * 0.035,
                            child: Container(
                              width: screenWidth * 0.21,
                              height: screenWidth * 0.21,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/log6.png"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth * 0.14 / 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.19,
                    right: screenWidth * 0.19,
                    top: screenHeight * 0.17,
                    child: Text(
                      'Add SOS contact',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF683F72),
                        fontSize: screenHeight * 0.023,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),


                  Positioned(
                    left: screenWidth * 0.10,
                    top: screenHeight * 0.36,
                    child: SizedBox(
                      width: screenWidth * 0.70,
                      child: Text(
                        'Make this person my SOS contact',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF683F72),
                          fontSize: 14,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.06,
                    top: screenHeight * 0.355,
                    child: Container(
                      width: screenWidth * 0.055,
                      height: screenHeight * 0.036,
                      child: Icon(Icons.star, color: Color(0xFF4C2559), size: screenHeight * 0.023),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.06,
                    right: screenWidth * 0.05,
                    top: screenHeight * 0.413,
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.22,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFBF2FB),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFA68CAF)),
                          borderRadius: BorderRadius.circular(screenWidth * 0.027),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 45,
                    top: screenHeight * 0.45,
                    child: Container(
                      width: screenWidth * 0.065,
                      height: screenWidth * 0.065,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/multiple-users-silhouette.png"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.412,
                    right: screenWidth * 0.412,
                    top: screenHeight * 0.22,
                    child: Container(
                      width: screenWidth * 0.14,
                      height: screenWidth * 0.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/multiple-users-silhouette.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.09,
                    top: screenHeight * 0.428,
                    child: SizedBox(
                      width: screenWidth * 0.4,
                      child: Text(
                        'Friend',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF683F72),
                          fontSize: screenHeight * 0.022,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 55,
                    top: screenHeight * 0.535,
                    child: SizedBox(
                      width: screenWidth * 0.412,
                      child: Text(
                        'SOS Contact',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF683F72),
                          fontSize: screenHeight * 0.018,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 85,
                    top: screenHeight * 0.46,
                    child: SizedBox(
                      width: screenWidth * 0.658,
                      child: Text(
                        'You can share your live location with your friends using the track me feature.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 91,
                    top: screenHeight * 0.56,
                    child: SizedBox(
                      width: screenWidth * 0.712,
                      child: Text(
                        'You can send SOS alerts only to the SOS contacts durings on emergency.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.07,
                    top: screenHeight * 0.6,
                    child: Container(width: screenWidth * 0.1, height: screenWidth * 0.09),
                  ),
                  Positioned(
                    left: 45,
                    top: screenHeight * 0.55,
                    child: Container(
                      width: screenWidth * 0.070,
                      height: screenWidth * 0.070,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/sos.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.76,
                    left: screenWidth * 0.19,
                    child: Stack(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSearch()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4C2559),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.04),
                            ),
                            minimumSize: Size(
                              screenWidth * 0.60,
                              screenHeight * 0.06,
                            ),
                          ),
                          child: Text(
                            "Add SOS Contact",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.018,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

