import 'package:flutter/material.dart';
import '../../../shared/resources/assets_manger.dart';


class BuildLogoWidget extends StatelessWidget {
  const BuildLogoWidget({Key? key, this.img = AppImages.appLogo})
      : super(key: key);
  final String img;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      img,
    );
  }
}
