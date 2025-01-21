import 'dart:async'; // Importing async library for Timer

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_export.dart';
import '../../core/utils/navigator_service.dart';
import '../../routes/app_routes.dart';
import '../../theme/theme_helper.dart';
import 'provider/splash_provider.dart';
import 'models/splash_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SplashProvider(), child: SplashScreen());
  }
}

class SplashScreenState extends State<SplashScreen> {
  bool _permissionsRequested = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();

    // Start a timer for 10 minutes
    Timer(Duration(minutes: 10), () {
      // Navigate after 10 minutes
      NavigatorService.popAndPushNamed(AppRoutes.signUpLoginScreen);
    });
  }

  void _requestPermissions() async {
    setState(() {
      _permissionsRequested = true;
    });

    await _requestContactsPermission();
    await _requestPhoneCallPermission();
    await _requestSMSPermission();
    await _requestLocationPermission();
    await _requestMicrophonePermission();
    await _requestInternetPermission();


    // Navigating after permissions are requested
    NavigatorService.popAndPushNamed(AppRoutes.signUpLoginScreen);
  }

  Future<void> _requestContactsPermission() async {
    // Request permission to access contacts
    PermissionStatus status = await Permission.contacts.request();
    if (!status.isGranted) {
      // Permission is denied
      // You might want to inform the user why the permission is needed
    }
  }

  Future<void> _requestInternetPermission() async {
    // Request permission to access contacts
    PermissionStatus status = await Permission.contacts.request();
    if (!status.isGranted) {
      // Permission is denied
      // You might want to inform the user why the permission is needed
    }
  }


  Future<void> _requestLocationPermission() async {
    // Request permission to access contacts
    PermissionStatus status = await Permission.location.request();
    if (!status.isGranted) {
      // Permission is denied
      // You might want to inform the user why the permission is needed
    }
  }

  Future<void> _requestMicrophonePermission() async {
    // Request permission to access contacts
    PermissionStatus status = await Permission.microphone.request();
    if (!status.isGranted) {
      // Permission is denied
      // You might want to inform the user why the permission is needed
    }
  }

  Future<void> _requestPhoneCallPermission() async {
    // Request permission to make phone calls
    PermissionStatus status = await Permission.phone.request();
    if (!status.isGranted) {
      // Permission is denied
      // You might want to inform the user why the permission is needed
    }
  }

  Future<void> _requestSMSPermission() async {
    // Request permission to send SMS
    PermissionStatus status = await Permission.sms.request();
    if (!status.isGranted) {
      // Permission is denied
      // You might want to inform the user why the permission is needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: appTheme.purple200,
      body: Stack(
        children: [
          _buildContent(screenHeight, screenWidth),
          if (_permissionsRequested)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(double screenHeight, double screenWidth) {
    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: screenHeight,
                width: screenWidth,
                margin: EdgeInsets.only(
                  left: screenWidth * 0.00276,
                  right: screenWidth * 0.00276,
                  bottom: screenHeight * 0.01,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: screenHeight * 0.4026,
                        width: screenWidth * 0.7251,
                        margin:
                        EdgeInsets.only(top: screenHeight * 0.2570),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image(
                              image: AssetImage("assets/log5.png"),
                              height: 500,
                              width: 500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: screenHeight,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.0138),
                          gradient: LinearGradient(
                            begin: Alignment(0.5, 1.5),
                            end: Alignment(0.5, 0.29),
                            colors: [
                              appTheme.purple50D1,
                              appTheme.purple100C9,
                              appTheme.blueGray10000,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
