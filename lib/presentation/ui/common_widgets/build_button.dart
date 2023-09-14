import 'package:flutter/material.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/responsive_screens_controller.dart';


class BuildButton extends StatelessWidget {
  BuildButton(
      {Key? key,
      required this.btnText,
      this.btnColor = ColorManager.homeColorDark,
        this.textColor=Colors.white,
        this.width,
        this.height,
        required  this.onTap,
      })
      : super(key: key);
  final String btnText;
  final Color btnColor;
  final Color textColor;
  final double ?width;
  final double ?height;
  final GestureTapCallback onTap;


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
              alignment: Alignment.center,
              width: width??ScreenSize.screenWidth * 0.62,
              height: height??ScreenSize.screenHeight * 0.06,
              margin: EdgeInsets.only(top: ScreenSize.screenHeight * .015),
              decoration: BoxDecoration(
                color: btnColor,
                borderRadius: BorderRadius.circular(ScreenSize.screenWidth*.05),
              ),
              child: Text(btnText,
                  style:  TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800)),
            ),
    );
  }
}
