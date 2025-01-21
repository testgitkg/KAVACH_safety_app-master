import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> setupPushNotifications() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.notification?.title}");
      // Handle incoming message
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message opened app: ${message.notification?.title}");
      // Handle opening app from notification
    });

    // Get the token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
  }

  initialize() {}
}
