import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/constants.dart';

class CustomAuthButtonWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CustomAuthButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: 264.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          gradient: kGradient,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
                color: kWhiteColor, fontSize: 14, letterSpacing: 0.25),
          ),
        ),
      ),
    );
  }
}
