

import 'package:flutter/cupertino.dart';
import 'package:garuda_cabin_mobile/screens/login_screen.dart';
import 'package:garuda_cabin_mobile/screens/splash_screen.dart';

final routes = {
  '/'       :(BuildContext context) => new SplashScreen(), //splash screen
  '/login'  :(BuildContext context) => new LoginScreen(), //login form
  '/home'   :(BuildContext context) => null, //home
};