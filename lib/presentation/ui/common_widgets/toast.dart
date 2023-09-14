import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../shared/di/injection.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/responsive_screens_controller.dart';
import '../../../shared/resources/routes_manager.dart';
import 'build_text.dart';

class SimpleToast extends StatelessWidget {
  SimpleToast({super.key, required this.msg});
  final String msg;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenSize.screenWidth * 0.95,
      padding: EdgeInsets.all(ScreenSize.screenWidth*0.06),
      child:  BuildText(txt: msg,
        color: Colors.black,
        fontSize: ScreenSize.screenWidth*.05,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}



Future<void> showSimpleToast({required String msg}) async {
  await showDialog(
    barrierDismissible: true,
    context: sl<NavigatorManager>().navigatorKey.currentContext!,
    builder: (context) {
      return BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: ScreenSize.screenWidth * (1 / 1280.0),
          sigmaY: ScreenSize.screenWidth * (1 / 1280.0),
        ),
        child:  Dialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          backgroundColor: Colors.white,
          child: SimpleToast(msg: msg),
        ),
      );
    },
  );
}