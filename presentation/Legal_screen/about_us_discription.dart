

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class about_us_screen extends StatefulWidget {
  const about_us_screen({super.key});

  @override
  State<about_us_screen> createState() => _about_us_screenState();
}

class _about_us_screenState extends State<about_us_screen> {
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
                'About Kavach',
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
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 200,width: 200,
                                  child: Image(image: AssetImage("assets/log5.png"))),
                            ),
                           // Text("Our Mission",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            //Text("At KAVACH, our mission is to empower women by providing them with the tools and resources they need to feel safe and secure in any situation. We are dedicated to creating innovative solutions that address the unique safety concerns faced by women around the world.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),
                            //SizedBox(height: 15,),
                            //Text("Our Vision",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            //Text("We envision a world where every woman can move through life with confidence and peace of mind, knowing that help is always within reach. Through our app, we aim to foster a supportive community where women can connect, share, and support each other.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),
                            //SizedBox(height: 15,),
                            Text("How KAVACH work?",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            Text("Kavach is a safety app for women, inspired by real-life experiences. It uses smart technology to help women feel secure wherever they go With simple voice commands like 'Save me', it is easy to activate help quickly ,Kavach is like having a trusted friend by your side, offering peace of mind and protection in any situation.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),
                            SizedBox(height: 15,),
                            Text("Voice Recognition SOS Alert :",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            Text("Kavach employs voice recognition technology to detect a predefined code word, triggering an SOS alert to designated contacts in the user's network.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),
                            SizedBox(height: 15,),
                            Text("Live Location Sharing :",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            Text("When an SOS alert is activated, Kavach automatically sends the user's live location to the designated contacts,user can add the SOS contacts as per their choise and also can delete the SOS contacts ,ensuring swift assistance in emergency situations.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),
                            SizedBox(height: 15,),
                            Text("E-Learning Platform :",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            Text("Kavach offers an integrated e-learning platform, providing users with access to educational resources and courses for personal development and skill enhancement regarding personal safety.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),
                            SizedBox(height: 15,),
                            Text("National Helpline Integration :",style: TextStyle(color: Color(0xFF4C2559),fontSize: 18,fontWeight: FontWeight.w800),),
                            Text("The application includes integration with national helpline services, offering additional support and resources to users in times of need.",style: TextStyle(color: Color(0xFF4C2559),fontSize: 14,),),

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
