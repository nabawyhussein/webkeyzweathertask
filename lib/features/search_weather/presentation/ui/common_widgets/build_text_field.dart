
import 'package:flutter/material.dart';

import '../../../../../core/shared/resources/colors_manager.dart';
import '../../../../../core/shared/resources/responsive_screens_controller.dart';



class BuildTextField extends StatelessWidget {
   BuildTextField(
      {Key? key,
      this.labelTxt,
      this.width,
      this.maxLines,
        this.onChange,
        this.suffixIcon,
        this.textDirect,
        this.whyToWorkValidation=false,
        this.textAlign= TextAlign.center,
      required this.textController,
        this.isDate=false,
      this.keyboardType,this.readonly=false})
      : super(key: key);
   String? labelTxt;
  final double? width;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextEditingController textController;
  final bool readonly;
  final bool isDate;
  final Widget ?suffixIcon;
  final TextAlign textAlign;
  final bool whyToWorkValidation;
  final ValueChanged? onChange;
  final TextDirection? textDirect;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        width: width ?? ScreenSize.screenWidth * 0.85,
         height: ScreenSize.screenHeight * 0.055,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenSize.screenWidth*.05),

          border: Border.all(color: ColorManager.borderColor,width: 2),

        ),
        child:
        TextFormField(
          controller: textController,
          maxLines: maxLines ?? 1,
          readOnly: readonly,
          onChanged: onChange,
          textDirection: textDirect,
          textAlign: textAlign,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            hintText: labelTxt,
            suffixIcon: suffixIcon,
            hintStyle: const TextStyle(
              color: Colors.black,
                fontWeight: FontWeight.bold),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(ScreenSize.screenWidth*.05),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(ScreenSize.screenWidth*.05),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(ScreenSize.screenWidth*.05),
            ),
          ),
          validator: (value) {
            // if (value == null || value.isEmpty) {
            //   return LocaleKeys.pleaseEnterCorrectData.tr();
            // }
            // else if(whyToWorkValidation&&value.length<50){
            //  return LocaleKeys.whyToWorkValidation.tr();
            // }
            return null;
          },
          onSaved: (f){

          },
          // onFieldSubmitted: (fff){
          //   debugPrint('fffffffffffffffffffffffffffffffffffff');
          // },
        ));
  }
}
