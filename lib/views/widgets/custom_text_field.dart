import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helpers/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.customFontSize,
    this.withoutPrefix = true,
    this.withoutSuffix = true,
    required this.controller,
    this.icon,
    this.textInputType = TextInputType.text,
    this.maxLine = 1,
    this.iconColor = const Color(0xff707070),
    this.paddingHor = 16,
    this.suffixIcon = Icons.info_outline,
    this.suffixFunction,
    this.hintColor = kGreyWhiteColor,
    // this.backgrundColor = Colors.white
  });
  // this.backgrundColor = const Color(0xff707070)});

  final TextInputType? textInputType;
  final Color? iconColor;
  final Color hintColor;
  // final Color backgrundColor;
  final int? maxLine;
  final String hintText;
  final double customFontSize;
  final int? paddingHor;
  final bool? withoutPrefix;
  final bool? withoutSuffix;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final Function()? suffixFunction;

  @override
  Widget build(BuildContext context) {
    //TODO: Add select the content of text field to copy or cut .....
    return TextField(
      controller: controller,
      maxLines: maxLine, //add more one line
      keyboardType: textInputType,
      //TODO :Create new color
      style: const TextStyle(color: Color(0xff707070)),
      cursorColor: const Color(0xff707070),
      decoration: InputDecoration(
        //filled: true, //<-- SEE HERE
        //fillColor: backgrundColor,

        contentPadding: withoutPrefix == true
            ? EdgeInsets.symmetric(horizontal: paddingHor!.w)
            : const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        focusedBorder: buildOutlineInputBorderTextField(),
        enabledBorder: buildOutlineInputBorderTextField(),
        prefixIcon: withoutPrefix == true
            ? null
            : Icon(
                icon,
                color: iconColor,
              ),
        hintText: hintText,
        hintStyle: buildAppBarTextStyle(
            fontSizeController: customFontSize,
            color: hintColor,
            //TODO : Check below color !!!!!!
            // color: const Color(0xffafafaf),
            letterSpacing: 0.15),
        suffixIcon: withoutSuffix == true
            ? null
            : InkWell(
                onTap: suffixFunction,
                child: Icon(
                  suffixIcon,
                  color: kLightBlueColor,
                ),
              ),
      ),
    );
  }
}
