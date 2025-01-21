// helpline_provider.dart

import 'package:flutter/material.dart';

import '../models/National_helpline_screen_,model.dart';

class HelplineProvider extends ChangeNotifier {
  List<HelplineModel> _helplines = [
    HelplineModel(
      title: 'National Helpline',
      description: 'Common Helpline Numbers listed here',
      image : 'assets/play-button-arrowhead.png',
      imagePath: "assets/contact-book (1).png",
    ),
    // Add more helplines as needed
  ];

  List<HelplineModel> get helplines => _helplines;

// You can add methods here to modify helplines list if needed
}
