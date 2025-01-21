
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help_screen extends StatefulWidget {
  const Help_screen({super.key});

  @override
  State<Help_screen> createState() => _Help_screenState();
}

class _Help_screenState extends State<Help_screen> {
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
                              Column(
                                children: [
                                  Text("Contact KAVACH_TEAM for Women's Safety Support",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
                                  SizedBox(height: 10,),
                                  Text("Welcome to our Women Safety App! Your safety and well-being are our top priorities. If you have any questions, concerns, or feedback, please don't hesitate to reach out to us. Our dedicated support team is here to assist you in any way we can.",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("We value your feedback and suggestions for improving our services. If you have any comments, ideas, or concerns, please don't hesitate to reach out to us. Your input helps us better serve the needs of women in our community.",style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                                  Text("For more details about KAVACH contact us within this email:")
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  _launchEmail(context);
                                },
                                  child: Text("kavach645@gmail.com",style: TextStyle(color: Colors.blue,fontSize: 15,decoration: TextDecoration.underline,),)),
                              // TextButton(
                              //   onPressed: () {
                              //     _launchEmail(context);
                              //   },
                              //   child: Text(
                              //     'kavach1@gmail.com',
                              //     style: TextStyle(
                              //       fontSize: 15,
                              //       color: Colors.blue,
                              //       decoration: TextDecoration.underline,
                              //     ),
                              //   ),
                              // ),,
                              SizedBox(height: 10,),
                              Text("At KAVACH, we are committed to promoting women's safety, empowerment, and well-being. No matter what challenges you may be facing, remember that you are not alone. Reach out to us today, and let us support you on your journey towards a brighter, safer future.")
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

  void _launchEmail(BuildContext context) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'kavach645@gmail.com', // Replace with your email address
      query: 'subject=About%20KAVACH', // You can set a default subject here
    );
    final String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch email app')),
      );
    }
  }

}
