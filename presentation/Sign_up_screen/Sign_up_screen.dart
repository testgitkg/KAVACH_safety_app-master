// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:kavach_project/localization/app_localization.dart';
// import 'package:kavach_project/presentation/Sign_up_screen/provider/Sign_up_provider.dart';
// import 'package:provider/provider.dart';
// import '../home_page/home_page.dart';
// import '../sign_up_login_screen/sign_up_login_screen.dart';
//
// class Register extends StatelessWidget {
//   const Register({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => RegisterProvider(),
//       child: RegisterScreen(),
//     );
//   }
// }
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//
//   final _formkey=GlobalKey<FormState>();
//
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   FirebaseAuth _auth=FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   bool _isLoading = false; // Track loading state
//
//
//   // void _addUserToAdminPage() async {
//   //   String email = _emailController.text;
//   //   String phone = _phoneController.text;
//   //   String username = _usernameController.text;
//   //
//   //
//   //   if (email.isNotEmpty && phone.isNotEmpty && username.isNotEmpty ) {
//   //     await _firestore.collection('user').add({
//   //       'email': _emailController.text.trim(),
//   //       'phone': _phoneController.text.trim(),
//   //       'firstname':_usernameController.text.trim(),
//   //
//   //     });
//   //     print('Added Successfully');
//   //   }
//   // }
//
//   String? _validateUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your username';
//     }
//     return null;
//
//
//   }
//
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     }
//     // You can add more specific email validation if needed
//     // return null;
//     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
//     return null;
//   }
//
//   String? _validatePhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your phone number';
//     }
//     // You can add more specific phone number validation if needed
//     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a password';
//     }
//     // You can add more specific password validation if needed
//     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
//     return null;
//   }
//
//   String? _validateConfirmPassword(String? value) {
//     if (value != _passwordController.text) {
//       return 'Passwords do not match';
//     }
//
//     //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
//     return null;
//   }
//
//
//   bool _obscureText = true;
//
//   // void _registerUser() async {
//   //   //  final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   try {
//   //     final UserCredential userCredential =
//   //     await _auth.createUserWithEmailAndPassword(
//   //       email: _emailController.text.trim(),
//   //       password: _passwordController.text,
//   //     );
//   //
//   //     if (userCredential.user != null) {
//   //       CollectionReference users = FirebaseFirestore.instance.collection('user');
//   //
//   //       await users.doc(userCredential.user!.uid).set({
//   //         'email': _emailController.text.trim(),
//   //         'phone': _phoneController.text.trim(),
//   //         'firstname':_usernameController.text.trim(),
//   //
//   //       });
//   //       // await prefs.setBool('isLogin', true);
//   //       print("Added Successfully in database");
//   //
//   //
//   //     }
//   //   } catch (e) {
//   //     showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return AlertDialog(
//   //           title: Text('Error'),
//   //           content: Text(e.toString()),
//   //           actions: <Widget>[
//   //             TextButton(
//   //               onPressed: () => Navigator.of(context).pop(),
//   //               child: Text('OK'),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
//
//
//   // void _registerUser() async {
//   //   String email = _emailController.text;
//   //   String phone = _phoneController.text;
//   //   String username = _usernameController.text;
//   //   String password = _passwordController.text;
//   //
//   //   try {
//   //     // Register the user with Firebase Authentication
//   //     final UserCredential userCredential =
//   //     await _auth.createUserWithEmailAndPassword(
//   //       email: email.trim(),
//   //       password: password,
//   //     );
//   //
//   //     // Check if user registration is successful
//   //     if (userCredential.user != null) {
//   //       // Add user data to Firestore with UID as document ID
//   //       await _firestore.collection('all_users').doc(userCredential.user!.uid).set({
//   //         'email': email.trim(),
//   //         'phone': phone.trim(),
//   //         'firstname': username.trim(),
//   //       });
//   //
//   //       print('User registered successfully');
//   //       // Navigate to home page after successful registration
//   //       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//   //     }
//   //   } catch (e) {
//   //     // Handle registration errors
//   //     print("Error registering user: $e");
//   //     // Display error message to user if needed
//   //     showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return AlertDialog(
//   //           title: Text('Registration Error'),
//   //           content: Text(e.toString()),
//   //           actions: <Widget>[
//   //             TextButton(
//   //               onPressed: () => Navigator.of(context).pop(),
//   //               child: Text('OK'),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
//
//   void _registerUser() async {
//     // Set loading state to true
//     setState(() {
//       _isLoading = true;
//     });
//
//     String email = _emailController.text;
//     String phone = _phoneController.text;
//     String username = _usernameController.text;
//     String password = _passwordController.text;
//
//     try {
//       // Register the user with Firebase Authentication
//       final UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password,
//       );
//
//       // Check if user registration is successful
//       if (userCredential.user != null) {
//         // Add user data to Firestore with UID as document ID
//         await _firestore.collection('all_users').doc(userCredential.user!.uid).set({
//           'email': email.trim(),
//           'phone': phone.trim(),
//           'firstname': username.trim(),
//         });
//
//         print('User registered successfully');
//         // Navigate to home page after successful registration
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//       }
//     } catch (e) {
//       // Handle registration errors
//       print("Error registering user: $e");
//       // Display error message to user if needed
//
//       // Set loading state back to false
//       setState(() {
//         _isLoading = false;
//       });
//
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Registration Error'),
//             content: Text(e.toString()),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//
//
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.start,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Form(
//               key: _formkey,
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,top: MediaQuery.of(context).size.width * 0.04),
//                         child: InkWell(
//                             onTap: (){
//                               Navigator.pop(context);
//                             },
//                             child: Icon(Icons.arrow_back_ios_new_sharp, size: MediaQuery.of(context).size.width * 0.06, color: Color(0xFF4C2559))),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
//                         child: Container(
//                           child: Image.asset(
//                             'assets/log6.png',
//                             fit: BoxFit.fitHeight,
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width * 0.18,
//                             height: MediaQuery.of(context).size.width * 0.24,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.30,top: MediaQuery.of(context).size.width * 0.05),
//                         child: Text(
//                           "kavach",
//                           style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.064, color: Color(0xFF4C2559),fontWeight: FontWeight.w600,fontFamily: 'kalam'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     thickness: MediaQuery.of(context).size.width * 0.012,
//                     color: Colors.grey.shade100,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.06),
//                           child: Text(
//                             "Create Your Account",
//                             style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055, color: Color(0xFF4C2559)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.011, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child: TextFormField(
//                       style: TextStyle(height: 1.2,color: Colors.black),
//                       controller: _usernameController,
//                       cursorColor: Colors.black,
//                       validator: _validateUsername,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
//                           hintText: "Username",
//                           hintStyle: TextStyle(fontSize: 14),
//                           fillColor: Colors.grey.shade200,
//                           filled: true,
//                           prefixIcon: Icon(Icons.person)
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child:
//                     TextFormField(
//
//                       style: TextStyle(height: 1.2,color: Colors.black),
//                       controller: _emailController,
//                       validator: _validateEmail,
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
//                           hintText: "Email",
//                           hintStyle: TextStyle(fontSize: 14),
//                           fillColor: Colors.grey.shade200,
//                           filled: true,
//                           prefixIcon: Icon(Icons.email)
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child: TextFormField(
//                       style: TextStyle(height: 1.2,color: Colors.black),
//                       controller: _phoneController,
//                       maxLength: 10,
//                       cursorColor: Colors.black,
//                       validator: _validatePhone,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
//                           hintText: "Phone No",
//                           hintStyle: TextStyle(fontSize: 14),
//                           fillColor: Colors.grey.shade200,
//                           filled: true,
//                           prefixIcon: Icon(Icons.phone_android)
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child: TextFormField(
//                       // validator: (value){
//                       //   if(value!.isEmpty){
//                       //     return "Enter Password";
//                       //   }
//                       //   return null;
//                       // },
//                       style: TextStyle(height: 1.2,color: Colors.black),
//                       cursorColor: Colors.black,
//                       controller: _passwordController,
//                       obscureText: true,
//                       validator: _validatePassword,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
//                         hintText: "Password",
//                         hintStyle: TextStyle(fontSize: 14),
//                         fillColor: Colors.grey.shade200,
//                         filled: true,
//                         prefixIcon: Icon(Icons.password),
//
//                       ),
//                       keyboardType: TextInputType.visiblePassword,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child: TextFormField(
//                       style: TextStyle(height: 1.2,color: Colors.black),
//                       cursorColor: Colors.black,
//                       controller: _confirmPasswordController,
//                       obscureText: true,
//                       validator: _validateConfirmPassword,
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
//                           hintText: "Confirm Password",
//                           hintStyle: TextStyle(fontSize:14),
//                           fillColor: Colors.grey.shade200,
//                           filled: true,
//                           prefixIcon: Icon(Icons.password)
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ),
//
//
//                   // Padding(
//                   //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                   //   child: ElevatedButton(
//                   //     onPressed: () {
//                   //       _registerUser();
//                   //      // _addUserToAdminPage();
//
//                   //
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //       backgroundColor: Color(0xFF4C2559),
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                   //       ),
//                   //       minimumSize: Size(
//                   //         MediaQuery.of(context).size.width * 0.90,
//                   //         MediaQuery.of(context).size.height * 0.06,
//                   //       ),
//                   //     ),
//                   //     child: Text(
//                   //       "SIGN UP",
//                   //       style: TextStyle(
//                   //         color: Colors.white,
//                   //         fontSize: 13,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child: Stack(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             if (!_isLoading) {
//                               _registerUser();
//                               if (_formkey.currentState!.validate()) {
//                                 // Form is valid, proceed with registration
//                                 _auth.createUserWithEmailAndPassword(
//                                   email: _emailController.text.toString(),
//                                   password: _passwordController.text.toString(),
//                                 ).then((_) {
//                                   // Navigation to home page after successful registration
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//                                 }).catchError((error) {
//                                   // Handle registration errors
//                                   print("Error registering user: $error");
//                                   // Display error message to user if needed
//                                 });
//                               }
//                             }
//                           },
//                           child: Text(
//                             "SIGN UP",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF4C2559),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
//                             ),
//                             minimumSize: Size(
//                               MediaQuery.of(context).size.width * 0.90,
//                               MediaQuery.of(context).size.height * 0.06,
//                             ),
//                           ),
//                         ),
//                         if (_isLoading)
//                           Positioned.fill(
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//
//
//                   Padding(
//                     padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.080, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Already have an account?"),
//                         SizedBox( width: MediaQuery.of(context).size.height * 0.01,),
//                         InkWell(
//                             onTap: (){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpLoginScreen()));
//                             },
//                             child: Text("LOGIN",style: TextStyle(color: Color(0xFF4C2559),fontWeight: FontWeight.bold),)),
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
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kavach_project/localization/app_localization.dart';
import 'package:kavach_project/presentation/Sign_up_screen/provider/Sign_up_provider.dart';
import 'package:provider/provider.dart';
import '../home_page/home_page.dart';
import '../sign_up_login_screen/sign_up_login_screen.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formkey=GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false; // Track loading state


  // void _addUserToAdminPage() async {
  //   String email = _emailController.text;
  //   String phone = _phoneController.text;
  //   String username = _usernameController.text;
  //
  //
  //   if (email.isNotEmpty && phone.isNotEmpty && username.isNotEmpty ) {
  //     await _firestore.collection('user').add({
  //       'email': _emailController.text.trim(),
  //       'phone': _phoneController.text.trim(),
  //       'firstname':_usernameController.text.trim(),
  //
  //     });
  //     print('Added Successfully');
  //   }
  // }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;


  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // You can add more specific email validation if needed
    // return null;
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // You can add more specific phone number validation if needed
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    // You can add more specific password validation if needed
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    return null;
  }


  bool _obscureText = true;

  // void _registerUser() async {
  //   //  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     final UserCredential userCredential =
  //     await _auth.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text,
  //     );
  //
  //     if (userCredential.user != null) {
  //       CollectionReference users = FirebaseFirestore.instance.collection('user');
  //
  //       await users.doc(userCredential.user!.uid).set({
  //         'email': _emailController.text.trim(),
  //         'phone': _phoneController.text.trim(),
  //         'firstname':_usernameController.text.trim(),
  //
  //       });
  //       // await prefs.setBool('isLogin', true);
  //       print("Added Successfully in database");
  //
  //
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text(e.toString()),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }


  // void _registerUser() async {
  //   String email = _emailController.text;
  //   String phone = _phoneController.text;
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;
  //
  //   try {
  //     // Register the user with Firebase Authentication
  //     final UserCredential userCredential =
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password,
  //     );
  //
  //     // Check if user registration is successful
  //     if (userCredential.user != null) {
  //       // Add user data to Firestore with UID as document ID
  //       await _firestore.collection('all_users').doc(userCredential.user!.uid).set({
  //         'email': email.trim(),
  //         'phone': phone.trim(),
  //         'firstname': username.trim(),
  //       });
  //
  //       print('User registered successfully');
  //       // Navigate to home page after successful registration
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  //     }
  //   } catch (e) {
  //     // Handle registration errors
  //     print("Error registering user: $e");
  //     // Display error message to user if needed
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Registration Error'),
  //           content: Text(e.toString()),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // void _registerUser() async {
  //   // Set loading state to true
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   String email = _emailController.text;
  //   String phone = _phoneController.text;
  //   String username = _usernameController.text;
  //   String password = _passwordController.text;
  //
  //   try {
  //     // Register the user with Firebase Authentication
  //     final UserCredential userCredential =
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email.trim(),
  //       password: password,
  //     );
  //
  //     // Check if user registration is successful
  //     if (userCredential.user != null) {
  //       // Add user data to Firestore with UID as document ID
  //       await _firestore.collection('all_users').doc(userCredential.user!.uid).set({
  //         'email': email.trim(),
  //         'phone': phone.trim(),
  //         'firstname': username.trim(),
  //       });
  //
  //       print('User registered successfully');
  //       // Navigate to home page after successful registration
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  //     }
  //   } catch (e) {
  //     // Handle registration errors
  //     print("Error registering user: $e");
  //     // Display error message to user if needed
  //
  //     // Set loading state back to false
  //     setState(() {
  //       _isLoading = false;
  //     });
  //
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Registration Error'),
  //           content: Text(e.toString()),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }
  void _registerUser() async {
    // Set loading state to true
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String phone = _phoneController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    try {
      if (password != confirmPassword) {
        throw "Passwords do not match";
      }

      // Register the user with Firebase Authentication
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Check if user registration is successful
      if (userCredential.user != null) {
        // Add user data to Firestore with UID as document ID
        await _firestore.collection('all_users').doc(userCredential.user!.uid).set({
          'email': email.trim(),
          'phone': phone.trim(),
          'firstname': username.trim(),
        });

        print('User registered successfully');
        // Navigate to home page after successful registration
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      // Handle registration errors
      print("Error registering user: $e");
      // Display error message to user if needed

      // Set loading state back to false
      setState(() {
        _isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }



  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formkey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04,top: MediaQuery.of(context).size.width * 0.04),
                        child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios_new_sharp, size: MediaQuery.of(context).size.width * 0.06, color: Color(0xFF4C2559))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
                        child: Container(
                          child: Image.asset(
                            'assets/log6.png',
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.18,
                            height: MediaQuery.of(context).size.width * 0.24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.30,top: MediaQuery.of(context).size.width * 0.05),
                        child: Text(
                          "kavach",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.064, color: Color(0xFF4C2559),fontWeight: FontWeight.w600,fontFamily: 'kalam'),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: MediaQuery.of(context).size.width * 0.012,
                    color: Colors.grey.shade100,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.06),
                          child: Text(
                            "Create Your Account",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055, color: Color(0xFF4C2559)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.011, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child: TextFormField(
                      style: TextStyle(height: 1.2,color: Colors.black),
                      controller: _usernameController,
                      cursorColor: Colors.black,
                      validator: _validateUsername,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
                          hintText: "Username",
                          hintStyle: TextStyle(fontSize: 14),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: Icon(Icons.person)
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child:
                    TextFormField(

                      style: TextStyle(height: 1.2,color: Colors.black),
                      controller: _emailController,
                      validator: _validateEmail,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 14),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: Icon(Icons.email)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child: TextFormField(
                      style: TextStyle(height: 1.2,color: Colors.black),
                      controller: _phoneController,
                      maxLength: 10,
                      cursorColor: Colors.black,
                      validator: _validatePhone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
                          hintText: "Phone No",
                          hintStyle: TextStyle(fontSize: 14),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: Icon(Icons.phone_android)
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child: TextFormField(
                      // validator: (value){
                      //   if(value!.isEmpty){
                      //     return "Enter Password";
                      //   }
                      //   return null;
                      // },
                      style: TextStyle(height: 1.2,color: Colors.black),
                      cursorColor: Colors.black,
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 14),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        prefixIcon: Icon(Icons.password),

                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.026, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child: TextFormField(
                      style: TextStyle(height: 1.2,color: Colors.black),
                      cursorColor: Colors.black,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: _validateConfirmPassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.020, horizontal: MediaQuery.of(context).size.width * 0.045),
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(fontSize:14),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: Icon(Icons.password)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),


                  // Padding(
                  //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _registerUser();
                  //      // _addUserToAdminPage();

                  //
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Color(0xFF4C2559),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                  //       ),
                  //       minimumSize: Size(
                  //         MediaQuery.of(context).size.width * 0.90,
                  //         MediaQuery.of(context).size.height * 0.06,
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "SIGN UP",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 13,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child: Stack(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (!_isLoading) {
                              _registerUser();
                              // if (_formkey.currentState!.validate()) {
                              //   _registerUser();
                              //   // Form is valid, proceed with registration
                              //   _auth.createUserWithEmailAndPassword(
                              //     email: _emailController.text.toString(),
                              //     password: _passwordController.text.toString(),
                              //   ).then((_) {
                              //     // Navigation to home page after successful registration
                              //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                              //   }).catchError((error) {
                              //     // Handle registration errors
                              //     print("Error registering user: $error");
                              //     // Display error message to user if needed
                              //   });
                              // }
                            }
                          },
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4C2559),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                            ),
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.90,
                              MediaQuery.of(context).size.height * 0.06,
                            ),
                          ),
                        ),
                        if (_isLoading)
                          Positioned.fill(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.080, left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox( width: MediaQuery.of(context).size.height * 0.01,),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpLoginScreen()));
                            },
                            child: Text("LOGIN",style: TextStyle(color: Color(0xFF4C2559),fontWeight: FontWeight.bold),)),
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
