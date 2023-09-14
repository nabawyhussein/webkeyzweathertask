import 'package:flutter/cupertino.dart';
import 'package:webkeys/core/shared/resources/routes_manager.dart';

import '../di/injection.dart';

class ScreenSize {
  static double screenWidth = MediaQuery.of( sl<NavigatorManager>().navigatorKey.currentContext!).size.width;
  static double screenHeight = MediaQuery.of( sl<NavigatorManager>().navigatorKey.currentContext!).size.height;
}