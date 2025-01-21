import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach_project/presentation/Settings_screen/provider/settings_screen_provider.dart';
import 'package:provider/provider.dart';

import '../sign_up_login_screen/sign_up_login_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
    ),
  );
}


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  void logoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C2559),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text("No",style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.purple.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text("Yes",style: TextStyle(color: Color(0xFF4C2559)),),
              onPressed: () {
                logout(); // Call logout method if user chooses Yes
                // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpLoginScreen()));// Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Utils.showToast("Logged out successfully");
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpLoginScreen()));
    // Navigate back to the login screen or any other screen as needed
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Color(0xFF4C2659),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05, // Adjust position as needed
              left: 15,
              right: 0,
              child: Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple.shade100,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.10,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.88 - 50,
                  child:
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20,right: 10),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Terminate Account" container
                        SizedBox(height: 20), // Add space between "Terminate Account" and other settings
                        // Other settings
                        ...settingsProvider.settings.map((setting) {
                          return GestureDetector(
                            onTap: (){
                              // if (setting.title == "Terminate Account"){
                              //   logoutConfirmation(context);
                              // }
                               if (setting.title == "Log Out"){
                                logoutConfirmation(context);
                              }
                              else {

                              }
                              // if (setting.title == "Terminate Account") {
                              //   logoutConfirmation(context);
                              // } else {
                              //   // Handle tap for other settings
                              // }
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(setting.iconData, size: MediaQuery.of(context).size.width * 0.085, color: Color(0xFF4C2559)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 20, right: 15),
                                    child: Text(setting.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF4C2559))),
                                  ),
                                ],
                              ),
                              height: MediaQuery.of(context).size.width * 0.27,
                              width: MediaQuery.of(context).size.width * 0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.grey,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.purple.shade100,
                              ),
                            ),
                          );
                        }).toList(),
                        // Add two more containers
                        SizedBox(height: 20), // Add space between the second and third settings
                      ],
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

