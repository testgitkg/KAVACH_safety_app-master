// new_password_provider.dart

import 'package:flutter/material.dart';

import '../models/Newpassword_screen_model.dart';

class NewPasswordProvider extends ChangeNotifier {
  NewPasswordModel _newPasswordModel = NewPasswordModel(newPassword: '', confirmPassword: '');

  NewPasswordModel get newPasswordModel => _newPasswordModel;

  void updateNewPassword(String newPassword) {
    _newPasswordModel.newPassword = newPassword;
    notifyListeners();
  }

  void updateConfirmPassword(String confirmPassword) {
    _newPasswordModel.confirmPassword = confirmPassword;
    notifyListeners();
  }
}
