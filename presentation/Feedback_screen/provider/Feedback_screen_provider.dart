// feedback_provider.dart

import 'package:flutter/material.dart';

import '../models/Feedback_screen_model.dart';

class FeedbackProvider extends ChangeNotifier {
  FeedbackModel? _feedback;

  void setFeedback(FeedbackModel feedback) {
    _feedback = feedback;
    notifyListeners();
  }

  FeedbackModel? getFeedback() => _feedback;
}
