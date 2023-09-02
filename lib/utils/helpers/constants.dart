import 'package:flutter/material.dart';

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
const Color kMediumGreyColor = Color(0xFFB2B2B2);
const Color kBackgroundColor = Color(0xFFF7F6FF);

// ============= TEXT STYLES CONSTS ==============
TextStyle buildAppBarTextStyle(
        {Color color = kLightBlueColor,
        double fontSizeController = 18,
        double letterSpacing = 1.5}) =>
    TextStyle(
        color: color,
        letterSpacing: letterSpacing,
        fontSize: fontSizeController);
