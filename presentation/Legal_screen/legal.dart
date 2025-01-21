// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class Legal extends StatefulWidget {
// //   const Legal({Key? key})
// //       : super(
// //     key: key,
// //   );
// //
// //   @override
// //   State<Legal> createState() => _LegalState();
// // }
// //
// // class _LegalState extends State<Legal> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Padding(
// //               padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     children: [
// //                       Padding(
// //                         padding: const EdgeInsets.only(left: 10),
// //                         child: Icon(Icons.arrow_back_ios_new_sharp, size: MediaQuery.of(context).size.width * 0.05, color: Color(0xFF4C2559)),
// //                       ),
// //                       Expanded(
// //                         child: Center(
// //                           child: Text(
// //                             "Legal",
// //                             style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.048, color: Color(0xFF4C2559)),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: MediaQuery.of(context).size.height * 0.015),
// //                   Divider(
// //                     thickness: MediaQuery.of(context).size.width * 0.010,
// //                     color: Colors.grey.shade100,
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.only(top: 20),
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child:
// //                           GestureDetector(
// //                             onTap: (){
// //                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Legal()));
// //                             },
// //                             child: Container(
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(
// //                                   color: Colors.purple.shade100, // Set your desired border color here
// //                                   width: 1, // Set the width of the border
// //                                 ),
// //                                 borderRadius: BorderRadius.circular(10),
// //
// //                               ),
// //                               height: MediaQuery.of(context).size.width * 0.14,
// //                               width: MediaQuery.of(context).size.width * 0.88,
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 children: [
// //                                   Padding(
// //                                     padding: const EdgeInsets.all(10.0),
// //                                     child: Text("Terms and conditions",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF4C2559)),),
// //                                   ),
// //                                   SizedBox(width: 133.5,),
// //                                   Container(
// //                                       height: 25,width: 25,
// //                                       child: Image(image: AssetImage("assets/up-right-arrow_4664830.png"))),
// //                                   //  IconButton(onPressed: (){}, icon: Icon(Icons.upload_sharp)),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child:
// //                           GestureDetector(
// //                             onTap: (){
// //                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Legal()));
// //                             },
// //                             child: Container(
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(
// //                                   color: Colors.purple.shade100, // Set your desired border color here
// //                                   width: 1, // Set the width of the border
// //                                 ),
// //                                 borderRadius: BorderRadius.circular(10),
// //
// //                               ),
// //                               height: MediaQuery.of(context).size.width * 0.14,
// //                               width: MediaQuery.of(context).size.width * 0.88,
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 children: [
// //                                   Padding(
// //                                     padding: const EdgeInsets.all(10.0),
// //                                     child: Text("About Us",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF4C2559)),),
// //                                   ),
// //                                   SizedBox(width: 187),
// //                                   Container(
// //                                       height: 25,width: 25,
// //                                       child: Image(image: AssetImage("assets/up-right-arrow_4664830.png"))),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Legal extends StatefulWidget {
//   const Legal({Key? key})
//       : super(
//     key: key,
//   );
//
//   @override
//   State<Legal> createState() => _LegalState();
// }
//
// class _LegalState extends State<Legal> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.05),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: MediaQuery.of(context).size.width * 0.05),
//                         child: Icon(Icons.arrow_back_ios_new_sharp,
//                             size:
//                             MediaQuery.of(context).size.width * 0.05,
//                             color: Color(0xFF4C2559)),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             "Legal",
//                             style: TextStyle(
//                                 fontSize:
//                                 MediaQuery.of(context).size.width * 0.048,
//                                 color: Color(0xFF4C2559)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.015),
//                   Divider(
//                     thickness:
//                     MediaQuery.of(context).size.width * 0.010,
//                     color: Colors.grey.shade100,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.height * 0.02),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(
//                               MediaQuery.of(context).size.width * 0.02),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Legal()));
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.purple.shade100,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               height:
//                               MediaQuery.of(context).size.width * 0.14,
//                               width:
//                               MediaQuery.of(context).size.width * 0.88,
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(
//                                         MediaQuery.of(context)
//                                             .size
//                                             .width *
//                                             0.025),
//                                     child: Text(
//                                       "Terms and conditions",
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF4C2559)),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: MediaQuery.of(context)
//                                         .size
//                                         .width *
//                                         0.34,
//                                   ),
//                                   Container(
//                                       height: 25,
//                                       width: 25,
//                                       child: Image(
//                                           image: AssetImage(
//                                               "assets/up-right-arrow_4664830.png"))),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.all(
//                               MediaQuery.of(context).size.width * 0.02),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Legal()));
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.purple.shade100,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               height:
//                               MediaQuery.of(context).size.width * 0.14,
//                               width:
//                               MediaQuery.of(context).size.width * 0.88,
//                               child: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(
//                                         MediaQuery.of(context)
//                                             .size
//                                             .width *
//                                             0.025),
//                                     child: Text(
//                                       "About Us",
//                                       style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF4C2559)),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: MediaQuery.of(context)
//                                         .size
//                                         .width *
//                                         0.56,
//                                   ),
//                                   Container(
//                                       height: 25,
//                                       width: 25,
//                                       child: Image(
//                                           image: AssetImage(
//                                               "assets/up-right-arrow_4664830.png"))),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach_project/presentation/Legal_screen/about_us_discription.dart';
import 'package:kavach_project/presentation/Legal_screen/terms_conditions_screen.dart';

class Legal_screen extends StatefulWidget {
  const Legal_screen({super.key});

  @override
  State<Legal_screen> createState() => _Legal_screenState();
}

class _Legal_screenState extends State<Legal_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Color(0xFF4C2659),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05, // Adjust position as needed
              left: 15,
              right: 0,
              child: Center(
                child: Text(
                  'Legal',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple.shade100,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.10,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.88 - 50,
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.02),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Terms_conditions()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.purple.shade100,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height:
                                  MediaQuery.of(context).size.width * 0.14,
                                  width:
                                  MediaQuery.of(context).size.width * 0.88,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.025),
                                        child: Text(
                                          "Terms and conditions",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4C2559)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.34,
                                      ),
                                      Container(
                                          height: 25,
                                          width: 25,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/up-right-arrow_4664830.png"))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>about_us_screen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.purple.shade100,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height:
                                  MediaQuery.of(context).size.width * 0.14,
                                  width:
                                  MediaQuery.of(context).size.width * 0.88,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.025),
                                        child: Text(
                                          "About Us",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4C2559)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.56,
                                      ),
                                      Container(
                                          height: 25,
                                          width: 25,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/up-right-arrow_4664830.png"))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
