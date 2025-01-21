import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/sign_up_login_model.dart';

/// A provider class for the SignUpLoginScreen.
///
/// This provider manages the state of the SignUpLoginScreen, including the
/// current signUpLoginModelObj
class SignUpLoginProvider extends ChangeNotifier {
  TextEditingController passcontroller = TextEditingController();
  TextEditingController emailcontroller=TextEditingController();

  SignUpLoginModel signUpLoginModelObj = SignUpLoginModel();

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
  }
}
