import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/helpers/constants.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  const CustomTextFormFieldWidget(
      {super.key,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
      this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          autofillHints: autofillHints,
          obscureText: password,
          enableSuggestions: password == true ? false : true,
          autocorrect: password == true ? false : true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 12.sp,
                letterSpacing: 0.4000000059604645,
                color: kMediumGreyColor),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: kMediumGreyColor),
            ),
            // focusedBorder: Styles.primaryRoundedOutlineInputBorder,
            // errorBorder: Styles.primaryRoundedOutlineInputBorder,
            // enabledBorder: Styles.primaryRoundedOutlineInputBorder,
            // disabledBorder: Styles.primaryRoundedOutlineInputBorder,
          ),
        ),
      ],
    );
  }
}
