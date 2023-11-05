import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/shared/resources/colors_manager.dart';
import '../../../../../core/shared/resources/constants_manager.dart';
import '../../../../../core/shared/resources/responsive_screens_controller.dart';

class BuildButtonWithBackGround extends StatelessWidget {
  const BuildButtonWithBackGround({
    Key? key,
    required this.btnText,
    this.btnColor = ColorManager.homeColorDark,
    this.textColor = Colors.white,
    this.width,
    this.height,
    required this.onTap,
  }) : super(key: key);
  final String btnText;
  final Color btnColor;
  final Color textColor;
  final double? width;
  final double? height;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? ScreenSize.screenWidth * 0.85,
        height: height ?? ScreenSize.screenHeight * 0.07,
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.screenWidth * .08),
        // margin: EdgeInsets.only(top: ScreenSize.screenHeight * .015),
        decoration: BoxDecoration(
          // color: btnColor,
          image: const DecorationImage(
              image: AssetImage("assets/backGrounds/buttonBackground.png"),
              fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(ConstantsManager.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(btnText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                )),
            SvgPicture.asset(
              'assets/backGrounds/buttonArrowForwardIcon.svg',
              // width: 50,
              // height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
