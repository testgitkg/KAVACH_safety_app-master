
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Terms_conditions extends StatefulWidget {
  const Terms_conditions({super.key});

  @override
  State<Terms_conditions> createState() => _Terms_conditionsState();
}

class _Terms_conditionsState extends State<Terms_conditions> {

  bool _acceptTerms = false;

  void _toggleTerms(bool value) {
    setState(() {
      _acceptTerms = value;
    });
  }


  void _acceptTermsAndContinue() {
    if (_acceptTerms) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Terms and Conditions'),
            content: Text('Please accept the terms and conditions to continue.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              color: Color(0xFF4C2659),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05, // Adjust position as needed
              left: 15,
              right: 0,
              child: Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.11,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.90,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to KAVACH',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text(
                              'These terms and conditions outline the rules and regulations for the use of Kavach.',
                              style: TextStyle(fontSize: 14,color: Colors.black),
                            ),
                            Text("By accessing this application, we assume you accept these terms and conditions. Do not continue to use Kavach."),
                            Text(
                              'Privacy Policy:',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text("Kavach collects your name, contact details, emergency contacts, and location information to provide emergency assistance and enhance user safety. We use this information to send notifications, personalize your experience, and analyze app usage for improvements. Your data is securely stored and you have the right to access, update, or delete it at any time."),
                            Text("Terms of Service:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text("By using Kavach, you agree to use the app responsibly and in compliance with local laws and regulations. Prohibited activities include engaging in illegal or harmful behavior, attempting to breach security measures, or interfering with app functionality. Kavach reserves the right to suspend or terminate your account for violating these terms."),
                            Text("Disclaimers:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text("Kavach is designed to provide assistance in non-life-threatening situations and enhance women safety. However, we cannot guarantee protection from all risks or threats. In emergencies, please contact local authorities or emergency services directly."),
                            Text("Community Guidelines:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text("We promote respectful behavior among Kavach users. Harassment, discrimination, or hate speech will not be tolerated. Users can report inappropriate content or behavior within the app for investigation and appropriate action."),
                            Text("Copyrights Notice:",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            Text("All content, logos, and trademarks displayed in Kavach are the property of our company and protected by copyright laws. Any unauthorized use or reproduction of our intellectual property is strictly prohibited."),
                            CheckboxListTile(
                              title: Text('I accept terms and conditions',textAlign: TextAlign.start,style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold),),
                              value: _acceptTerms,
                              onChanged: (bool? value) {
                                _toggleTerms(true);
                              },
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  backgroundColor: Color(0xFF4C2559),
                                ),
                                child: Text('Accepet & Continue',style: TextStyle(color: Colors.white),),
                                onPressed: _acceptTermsAndContinue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
