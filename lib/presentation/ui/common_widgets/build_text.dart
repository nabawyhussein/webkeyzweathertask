import 'package:flutter/material.dart';

import '../../../shared/resources/colors_manager.dart';


class BuildText extends StatelessWidget {
  const BuildText(
      {Key? key,
      required this.txt,
      this.fontSize,
        required this.color ,
      this.fontWeight,
      this.textAlign=TextAlign.center,
        this.maxLines,
      this.decoration = false})
      : super(key: key);
  final String? txt;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final bool decoration;
  final int ?maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt!,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          decoration:
              decoration ? TextDecoration.underline : TextDecoration.none),
    );
  }
}