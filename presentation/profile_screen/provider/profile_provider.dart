// import 'package:flutter/material.dart';
// import '../models/profile_model.dart';
//
// /// A provider class for the ProfileScreen.
// ///
// /// This provider manages the state of the ProfileScreen, including the
// /// current profileModelObj
// class ProfileProvider extends ChangeNotifier {
//   ProfileModel profileModelObj = ProfileModel();
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  File? _imageFile;

  File? get imageFile => _imageFile;

  void setImageFile(File? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }
}
