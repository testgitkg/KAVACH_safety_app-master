import 'package:flutter/material.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/sign_up_login_screen/sign_up_login_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String signUpLoginScreen = '/sign_up_login_screen';

  static const String passwordScreen = '/password_screen';

  static const String forgetPassScreen = '/forget_pass_screen';

  static const String homePage = '/home_page';

  static const String drawerScreen = '/drawer_screen';

  static const String profileScreen = '/profile_screen';

  static const String historyPage = '/history_page';

  static const String friendPage = '/friend_page';

  static const String friendTabContainerScreen = '/friend_tab_container_screen';

  static const String historyTwoScreen = '/history_two_screen';

  static const String historyThreePage = '/history_three_page';

  static const String historyThreeTabContainerScreen =
      '/history_three_tab_container_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        signUpLoginScreen: SignUpLoginScreen.builder,
        //forgetPassScreen: ForgetPass.builder,
     //   drawerScreen: DrawerScreen.builder,
       // profileScreen: ProfileScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: SplashScreen.builder
      };
}
