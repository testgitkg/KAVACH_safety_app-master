import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Sign_up_model.dart';

class RegisterProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(RegisterModel registerData) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: registerData.email,
        password: registerData.password,
      );
      // You can add further actions after successful sign up here
    } catch (e) {
      // Handle errors here
      print(e);
    }
  }
}
