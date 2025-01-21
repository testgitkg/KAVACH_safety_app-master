// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'core/app_export.dart';
//
// var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Future.wait([
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]),
//     PrefUtils().init()
//   ]).then((value) {
//     runApp(MyApp());
//   });
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return ChangeNotifierProvider(
//           create: (context) => ThemeProvider(),
//           child: Consumer<ThemeProvider>(
//             builder: (context, provider, child) {
//               return MaterialApp(
//                 theme: theme,
//                 title: 'kavach',
//                 navigatorKey: NavigatorService.navigatorKey,
//                 debugShowCheckedModeBanner: false,
//                 localizationsDelegates: [
//                   AppLocalizationDelegate(),
//                   GlobalMaterialLocalizations.delegate,
//                   GlobalWidgetsLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                 ],
//                 supportedLocales: [
//                   Locale(
//                     'en',
//                     '',
//                   ),
//                 ],
//                 initialRoute: AppRoutes.initialRoute,
//                 routes: AppRoutes.routes,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kavach_project/presentation/Feedback_screen/provider/Feedback_screen_provider.dart';
import 'package:kavach_project/presentation/National_helpline_screen/provider/National_helpline_screeen_provider.dart';
import 'package:kavach_project/presentation/Newpassword_screen/provider/Newpassword_screen_provider.dart';
import 'package:kavach_project/presentation/Settings_screen/provider/settings_screen_provider.dart';
import 'package:kavach_project/presentation/Sign_up_screen/provider/Sign_up_provider.dart';
import 'package:kavach_project/presentation/drawer_screen/provider/drawer_provider.dart';
import 'package:kavach_project/presentation/forget_pass_screen/provider/forget_pass_provider.dart';
import 'package:kavach_project/presentation/home_page/provider/home_provider.dart';
import 'package:kavach_project/presentation/invite_friend/provider/invite_friend_provider.dart';
import 'package:kavach_project/presentation/profile_screen/provider/profile_provider.dart';
import 'package:kavach_project/presentation/sign_up_login_screen/provider/sign_up_login_provider.dart';
import 'package:kavach_project/presentation/splash_screen/provider/splash_provider.dart';
import 'package:kavach_project/routes/app_routes.dart';
import 'package:kavach_project/theme/theme_helper.dart';
import 'core/app_export.dart';
import 'core/utils/navigator_service.dart';
import 'core/utils/size_utils.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'localization/app_localization.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider( // Use MultiProvider instead of ChangeNotifierProvider
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => SplashProvider()),
            ChangeNotifierProvider(create: (context) => SignUpLoginProvider()),
            ChangeNotifierProvider(create: (context) => RegisterProvider()),
            ChangeNotifierProvider(create: (context) => NewPasswordProvider()),
            ChangeNotifierProvider(create: (context) => HelplineProvider()),
            ChangeNotifierProvider(create: (context) => SettingsProvider()),
            ChangeNotifierProvider(create: (context) => FriendProvider()),
            ChangeNotifierProvider(create: (context) => ForgetPassProvider()),
            ChangeNotifierProvider(create: (context) => FeedbackProvider()),
            ChangeNotifierProvider(create: (context) => HomeProvider()),
            ChangeNotifierProvider(create: (context) => DrawerProvider()),
            ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                theme: theme,
                title: 'kavach',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale(
                    'en',
                    '',
                  ),
                ],
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes,
              );
            },
          ),
        );
      },
    );
  }
}


//       replace all the height and width with mediaquery without affecting original UI