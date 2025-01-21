import 'package:flutter/material.dart';

import '../models/forget_pass_model.dart';


/// A provider class for the ForgetPassScreen.
///
/// This provider manages the state of the ForgetPassScreen, including the
/// current forgetPassModelObj
class ForgetPassProvider extends ChangeNotifier {
  ForgetPassModel forgetPassModelObj = ForgetPassModel();

  @override
  void dispose() {
    super.dispose();
  }
}
