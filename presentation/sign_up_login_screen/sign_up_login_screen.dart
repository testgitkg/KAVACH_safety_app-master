import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kavach_project/localization/app_localization.dart';
import 'package:kavach_project/presentation/forget_pass_screen/email_recovery.dart';
import 'package:provider/provider.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_outlined_button.dart';
import '../Sign_up_screen/Sign_up_screen.dart';
import '../home_page/home_page.dart';

class SignUpLoginScreen extends StatefulWidget {
  const SignUpLoginScreen({Key? key}) : super(key: key);

  @override
  _SignUpLoginScreenState createState() => _SignUpLoginScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpLoginProvider(),
      child: SignUpLoginScreen(),
    );
  }
}

class _SignUpLoginScreenState extends State<SignUpLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    // Check if user is already signed in
    checkCurrentUser();
  }

  void checkCurrentUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // User is signed in
        navigateToHomePage();
      }
    });
  }

  void navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<void> _signInWithGoogle() async {
    try {
      // Attempt to sign out if already signed in
      await _googleSignIn.signOut();

      // Start the sign-in flow
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // User canceled the sign-in flow
        return;
      }

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // Get the user information
      final User? user = userCredential.user;

      if (user != null) {
        // Navigate to your desired screen after successful login
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));

        // Store user data in Firestore
        await storeUserData(user, googleSignInAccount);
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      // Handle sign-in errors here
    }
  }

  Future<void> storeUserData(User user, GoogleSignInAccount googleSignInAccount) async {
    // Create a Firestore reference to your users collection
    final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('google_users');

    // Check if the user already exists in Firestore
    DocumentSnapshot userSnapshot = await usersRef.doc(user.uid).get();

    if (!userSnapshot.exists) {
      // If user doesn't exist, store the user data in Firestore
      await usersRef.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'firstname': googleSignInAccount.displayName, // Store the user's name
        // Add other user data you want to store
      });
    }
  }

  void login() {
    if (_formkey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // Check if the user is blocked
      FirebaseFirestore.instance
          .collection('all_users')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var userData = querySnapshot.docs.first.data() as Map<String, dynamic>; // Explicit cast
          bool isBlocked = userData['blocked'] ?? false; // Use null-aware operator

          if (isBlocked) {
            // User is blocked
            Utils.showToast("$email is blocked"); // Show toast message
          } else {
            // User is not blocked, proceed with login
            FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password)
                .then((userCredential) {
              // Login successful
              String userEmail = userCredential.user!.email!;
              Utils.showToast("Logged in as $userEmail");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }).catchError((error) {
              // Login failed
              debugPrint("Login error: $error");
              Utils.showToast("Login failed. Please check your credentials.");
            });
          }
        } else {
          // User not found
          Utils.showToast("User not found");
        }
      }).catchError((error) {
        // Error handling
        Utils.showToast("Error: $error");
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              _buildAppBar(context),
              _buildStackWithAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lbl_sign_up_login".tr,
                          // Replace this with your localization logic
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.03),
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical:
                                  MediaQuery.of(context).size.height * 0.02,
                                  horizontal:
                                  MediaQuery.of(context).size.width * 0.03),
                              fillColor: Colors.grey.shade100,
                              focusColor: Colors.black,
                              filled: true,
                              hintText: "Email",
                              hintStyle: TextStyle(fontSize: 15),
                              prefixIcon: Icon(
                                Icons.email,
                                size: 16,
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.03),
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical:
                                  MediaQuery.of(context).size.height * 0.02,
                                  horizontal:
                                  MediaQuery.of(context).size.width * 0.03),
                              fillColor: Colors.grey.shade100,
                              focusColor: Colors.black,
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 15),
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 16,
                              )),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EmailRecovery()));
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(color: Color(0xFF4C2559)),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4C2559),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.04),
                            ),
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.90,
                              MediaQuery.of(context).size.height * 0.06,
                            ),
                          ),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.021,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                        MediaQuery.of(context).size.height *
                                            0.004,
                                        bottom:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                      ),
                                      child: Divider(
                                        color: appTheme.black900,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.02),
                                    child: Text(
                                      "lbl_or".tr,
                                      style: CustomTextStyles.bodyMedium15,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                        MediaQuery.of(context).size.height *
                                            0.004,
                                        bottom:
                                        MediaQuery.of(context).size.height *
                                            0.01,
                                      ),
                                      child: Divider(
                                        color: appTheme.black900,
                                        // indent: MediaQuery.of(context).size.width * 0.02,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 3, top: 11, right: 3),
                          child: CustomOutlinedButton(
                            onPressed: _signInWithGoogle,
                            text: "msg_continue_with_google".tr,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.004,
                              right: MediaQuery.of(context).size.width * 0.002,
                              top: MediaQuery.of(context).size.height * 0.002,
                              bottom:
                              MediaQuery.of(context).size.height * 0.002,
                            ),
                            leftIcon: Container(
                              margin: EdgeInsets.only(
                                  right:
                                  MediaQuery.of(context).size.width * 0.03),
                              child: CustomImageView(
                                imagePath: ImageConstant
                                    .imgVecteezygooglelogoontransparentbackgroundpopularsearchengine292849641,
                                height:
                                MediaQuery.of(context).size.height * 0.02,
                                width:
                                MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            buttonStyle:
                            CustomButtonStyles.outlineErrorContainer,
                            buttonTextStyle:
                            CustomTextStyles.bodySmallBlack90012,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Didn't have an account?"),
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "By continuing, you agree that you have read and accepted our",
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "T&Cs",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF4C2659),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005,
                            ),
                            Center(
                              child: Text(
                                "and",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.005,
                            ),
                            Center(
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF4C2659),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStackWithAppBar(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
            width: MediaQuery.of(context).size.width,
            // child: Stack(
            //   alignment: Alignment.centerRight,
            //   children: [
            //     Container(
            //       height: MediaQuery.of(context).size.height*0.09,
            //       width: MediaQuery.of(context).size.width*0.09,
            //       color: Colors.purple,
            //     ),
            //     // ),
            //     Align(
            //       alignment: Alignment.centerRight,
            //       child: Container(
            //         height: MediaQuery.of(context).size.height * 0.09,
            //         width: MediaQuery.of(context).size.width * 0.297,
            //         decoration: BoxDecoration(
            //           color:
            //           theme.colorScheme.onPrimaryContainer.withOpacity(1),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.0001),
          Divider(
            thickness: 5,
            color: Colors.grey.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Image.asset(
            "assets/log6.png",
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.18 + 9.0,
            top: MediaQuery.of(context).size.height * 0.032,
            child: Text(
              "kavach",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'kalam',
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class Utils {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
    );
  }
}

class SignUpLoginProvider extends ChangeNotifier {
  // You can implement provider related logic here if needed
}