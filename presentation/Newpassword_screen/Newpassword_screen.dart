// new_password.dart

import 'package:flutter/material.dart';
import 'package:kavach_project/presentation/Newpassword_screen/provider/Newpassword_screen_provider.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatelessWidget {

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<NewPasswordProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child:
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Center horizontally
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 12),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                                child: Icon(Icons.arrow_back_ios_new_sharp, size: 25, color: Color(0xFF4C2559))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: Container(
                              child: Image.asset(
                                'assets/log6.png',
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.center,
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 150,top: 10),
                            child: Text(
                              "kavach",
                              style: TextStyle(fontSize: screenWidth * 0.060, color: Color(0xFF4C2559),fontFamily: 'kalam',fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: screenWidth * 0.012,
                        color: Colors.grey.shade100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Center horizontally
                          children: [
                            Text(
                              "Create new password",
                              style: TextStyle(fontSize: screenWidth * 0.060, fontWeight: FontWeight.bold, color: Color(0xFF4C2559)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: screenWidth * 0.03),
                        child: Text(
                          'Your password must be different to previously used password',
                          style: TextStyle(fontSize: 15.5),
                          textAlign: TextAlign.start, // Align text at the center
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start, // Center vertically
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            child: Text("Enter New Password", style: TextStyle(fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _newPasswordController,
                              onChanged: (value) {
                                provider?.updateNewPassword(value);
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
                            child: Text("Re-enter New Password", style: TextStyle(fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              onChanged: (value) {
                                provider.updateConfirmPassword(value);
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                    borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
                            child: Text(
                              "A good password should have:",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF4C2559)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
                            child: Text("8 or more characters", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            child: Text("At least one numbers (0-9)", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            child: Text("A mixture of upper and lowercase", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18),
                            child: Text("At least 1 special character (!@#%^*()\$)", style: TextStyle(fontSize: 15, color: Color(0xFF4C2559))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 18, top: 40),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF4C2559),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                                  ),
                                  minimumSize: Size(
                                    screenWidth * 0.55,
                                    screenHeight * 0.06,
                                  ),
                                ),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
