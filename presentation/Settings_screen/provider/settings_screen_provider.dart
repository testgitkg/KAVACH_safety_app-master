import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/settings_screen_model.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners(); // Notify listeners to update the UI
  }
  List<SettingItem> settings = [
  //  SettingItem(title: "Terminate Account", iconData: Icons.account_circle),
    SettingItem(title: "Log Out", iconData: Icons.settings_power_rounded),

    // Add more settings items as needed
  ];
}
