import 'package:flutter/material.dart';
import '../models/chipview_item_model.dart';
import '../models/drawer_model.dart';

/// A provider class for the DrawerScreen.
///
/// This provider manages the state of the DrawerScreen, including the
/// current drawerModelObj

// ignore_for_file: must_be_immutable
class DrawerProvider extends ChangeNotifier {
  DrawerModel drawerModelObj = DrawerModel();

  bool isSelectedSwitch = false;

  @override
  void dispose() {
    super.dispose();
  }

  void changeSwitchBox1(bool value) {
    isSelectedSwitch = value;
    notifyListeners();
  }

  void onSelectedChipView1(
    int index,
    bool value,
  ) {
    drawerModelObj.chipviewItemList.forEach((element) {
      element.isSelected = false;
    });
    drawerModelObj.chipviewItemList[index].isSelected = value;
    notifyListeners();
  }
}
