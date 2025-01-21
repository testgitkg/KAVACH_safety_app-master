//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:kavach_project/presentation/history_page/history_page.dart';
// import 'package:kavach_project/presentation/invite_friend/invite_friend.dart';
//
// import '../Feedback_screen/Feedback_screen.dart';
// import '../add_friend.dart';
// import '../history_two_screen/history_two_screen.dart';
// import '../language.dart';
// import '../legal.dart';
// import '../settings.dart';
// import '../sign_up_login_screen/sign_up_login_screen.dart';
//
//
//
// class Drawerscreen extends StatefulWidget {
//   const Drawerscreen({Key? key}) : super(key: key);
//
//   @override
//   State<Drawerscreen> createState() => _DrawerscreenState();
// }
//
// class _DrawerscreenState extends State<Drawerscreen> {
//
//
//   bool isSwitched = false;
//   void logout() async {
//     await FirebaseAuth.instance.signOut();
//     Utils.showToast("Logged out successfully");
//     // Navigate back to the login screen or any other screen as needed
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child:
//             Container(
//               width: 394,
//               height: 825,
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(color: Color(0xFF4C2559)),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     top: 85,
//                     child: Container(
//                       width: 394,
//                       height: 790,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFF2DAF1),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(25),
//                             topRight: Radius.circular(25),),),),),),
//
//                   Padding(
//                     padding: const EdgeInsets.only(top: 250),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryPage()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/file.png"), height: MediaQuery.of(context).size.width * 0.09, width: MediaQuery.of(context).size.width * 0.1),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: Text("History", style: TextStyle(fontSize: 15,color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Addfriend()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/support.png"), height: MediaQuery.of(context).size.width * 0.12, width: MediaQuery.of(context).size.width * 0.13),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 7),
//                                   child: Text("Friends", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Addfriend()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/to-do-list.png"), height: MediaQuery.of(context).size.width * 0.09, width: MediaQuery.of(context).size.width * 0.13),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 7),
//                                   child: Text("Blocklist", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     top: 35,
//                     child: Container(
//                       width: 346,
//                       height: 45,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 57,
//                               height: 43,
//                               child: IconButton(onPressed: (){
//                                 Navigator.pop(context);
//                               }, icon: Icon(Icons.arrow_back_ios,color: Colors.purple.shade100,)),
//                             ),
//                           ),
//                           Positioned(
//                             left: 43,
//                             top: 4,
//                             child: SizedBox(
//                               width: 90,
//                               height: 29.95,
//                               child: Text(
//                                 'Kavach',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Color(0xFFEBB9E9),
//                                   fontSize: 25,
//                                   fontFamily: 'kalam',
//                                   fontWeight: FontWeight.w400,
//                                   height: 0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 320,
//                             top: 0,
//                             child: Container(
//                               width: 26,
//                               height: 25,
//                               child: IconButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   icon: Icon(Icons.cancel_outlined,color: Colors.purple.shade100,size: 30,)),
//                               // decoration: BoxDecoration(
//                               //   image: DecorationImage(
//                               //     image: AssetImage("assets/close.png",),
//                               //     fit: BoxFit.fill,
//                               //   ),
//                               // ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 400),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBackScreen()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/comment.png"), height: MediaQuery.of(context).size.width * 0.1, width: MediaQuery.of(context).size.width * 0.1),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: Text("Feedback", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Legal()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/legal-document.png"), height: MediaQuery.of(context).size.width * 0.09, width: MediaQuery.of(context).size.width * 0.13),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 7),
//                                   child: Text("Legal", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                         //    Navigator.push(context, MaterialPageRoute(builder: (context)=>Addfriend()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/help.png"), height: MediaQuery.of(context).size.width * 0.085, width: MediaQuery.of(context).size.width * 0.085),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 9),
//                                   child: Text("Help", style: TextStyle(fontSize: 15,color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 550),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Addfriend()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/study.png"), height: MediaQuery.of(context).size.width * 0.1, width: MediaQuery.of(context).size.width * 0.1),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: Text("E-learning", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/settings.png"), height: MediaQuery.of(context).size.width * 0.12, width: MediaQuery.of(context).size.width * 0.13),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 7),
//                                   child: Text("Settings", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             logout();
//                           },
//                           child: Container(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Image(image: AssetImage("assets/power-off.png"), height: MediaQuery.of(context).size.width * 0.085, width: MediaQuery.of(context).size.width * 0.085),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 9),
//                                   child: Text("Log-out", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
//                                 ),
//                               ],
//                             ),
//                             height: MediaQuery.of(context).size.width * 0.28,
//                             width: MediaQuery.of(context).size.width * 0.28,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               color: Colors.purple.shade50,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),)
//           ,],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kavach_project/presentation/E-learning/desc_eLearning.dart';
import 'package:kavach_project/presentation/Help_screen/help_screen.dart';
import 'package:kavach_project/presentation/Legal_screen/about_us_discription.dart';
import 'package:kavach_project/presentation/Legal_screen/terms_conditions_screen.dart';
import 'package:kavach_project/presentation/Settings_screen/settings_screen.dart';
import 'package:kavach_project/presentation/contactlist.dart';
import 'package:kavach_project/presentation/history_page/history_page.dart';
import 'package:kavach_project/presentation/invite_friend/invite_friend.dart';

import '../Feedback_screen/Feedback_screen.dart';
import '../home_page/home_page.dart';
import '../Legal_screen/legal.dart';
import '../sign_up_login_screen/sign_up_login_screen.dart';

class Drawerscreen extends StatefulWidget {
  const Drawerscreen({Key? key}) : super(key: key);

  @override
  State<Drawerscreen> createState() => _DrawerscreenState();
}

class _DrawerscreenState extends State<Drawerscreen> {
  bool isSwitched = false;

  void logoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C2559),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text("No",style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.purple.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text("Yes",style: TextStyle(color: Color(0xFF4C2559)),),
              onPressed: () {
                logout(); // Call logout method if user chooses Yes
               // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpLoginScreen()));// Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Utils.showToast("Logged out successfully");
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpLoginScreen()));
    // Navigate back to the login screen or any other screen as needed
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Color(0xFF4C2559)),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height * 0.108,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF2DAF1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildMenuContainer("assets/study.png", "E-learning", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => desc_eLearning()));

                        }),
                        // buildMenuContainer("assets/settings.png", "Settings", context, () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                        // }),
                        buildMenuContainer("assets/help.png", "Help", context, () {
                          //logoutConfirmation(context);
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Help_screen()));
                        }),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildMenuContainer("assets/file.png", "History", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
                        }),
                        buildMenuContainer("assets/contact-book (3).png", "SOS contact", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Addfriend()));
                        }),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height * 0.031,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.899,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.144,
                              height: MediaQuery.of(context).size.width * 0.140,
                              child: IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.purple.shade100,)),
                            ),
                          ),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.138,
                            top: MediaQuery.of(context).size.height * 0.011,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.225,
                              height: MediaQuery.of(context).size.height * 0.043,
                              child: Text(
                                'Kavach',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFEBB9E9),
                                  fontSize: 25,
                                  fontFamily: 'kalam',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.58),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildMenuContainer("assets/comment.png", "Feedback", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBackScreen()));
                        }),
                        buildMenuContainer("assets/legal-document.png", "Legal", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Terms_conditions()));
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.78),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildMenuContainer("assets/about us.png", "About us", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));

                        }),
                        buildMenuContainer("assets/settings.png", "Settings", context, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                        }),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuContainer(String imagePath, String label, BuildContext context, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(imagePath),
              height: MediaQuery.of(context).size.width * 0.08,
              width: MediaQuery.of(context).size.width * 0.13,
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
              child: Text(
                label,
                style: TextStyle(fontSize: 15, color: Color(0xFF4C2559)),
              ),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.width * 0.28,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.purple.shade50,
        ),
      ),
    );
  }
}
