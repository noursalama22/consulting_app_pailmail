import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

// ============= COLORS CONSTS ==============
const Color kLightBlueColor = Color(0xFF6589FF);
const Color kPrimaryBlueColor = Color(0xFF003AFC);
const Color kDarkGreyColor = Color(0xFF7C7C7C);
const Color kGreenColor = Color(0xFF77D16F);
const Color kYellowColor = Color(0xFFFFE120);
const Color kRedColor = Color(0xFFFA3A57);
const Color kBlackColor = Color(0xFF272727);
const Color kLightGreyColor = Color(0xFFE6E6E6);
const Color kWhiteColor = Color(0xFFFFFFFF);

const Color kGreyWhiteColor = Color(0xFF898989);
const Color kMediumGreyColor = Color(0xFFB2B2B2);
const Color kBackgroundColor = Color(0xFFF7F6FF);
TextStyle statusTextStyle = GoogleFonts.poppins(
  color: kMediumGreyColor,
  fontSize: 16,
);

TextStyle tileTextTitleStyle = GoogleFonts.poppins(
  color: kBlackColor,
  fontSize: 20,
);
TextStyle tileTextNumberStyle = GoogleFonts.poppins(
  color: kMediumGreyColor,
  fontSize: 14,
);
TextStyle tagsTextStyle = GoogleFonts.poppins(
  color: kLightBlueColor,
  fontSize: 14,
);
const kGradient = LinearGradient(
    colors: <Color>[kLightBlueColor, kPrimaryBlueColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

// ============= TEXT STYLES CONSTS ==============

TextStyle buildAppBarTextStyle(
        {Color color = kLightBlueColor,
        double fontSizeController = 18,
        double letterSpacing = 1.5}) =>
    TextStyle(
        color: color,
        letterSpacing: letterSpacing,
        fontSize: fontSizeController);

// ============= TextFieldBorder ==============

OutlineInputBorder buildOutlineInputBorderTextField() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none);
}

TextStyle kTextFieldTextStyle = GoogleFonts.poppins(
    fontSize: 12.sp,
    letterSpacing: 0.4000000059604645,
    color: kMediumGreyColor);

