import 'package:flutter/material.dart';

import '../models/history_model.dart';


/// A provider class for the HistoryPage.
///
/// This provider manages the state of the HistoryPage, including the
/// current historyModelObj
class HistoryProvider extends ChangeNotifier {
  HistoryModel historyModelObj = HistoryModel();

  @override
  void dispose() {
    super.dispose();
  }
}
