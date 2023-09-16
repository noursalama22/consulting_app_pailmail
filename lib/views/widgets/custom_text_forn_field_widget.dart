import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final bool isObscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final Function()? changeVisibility;

  const CustomTextFormFieldWidget(
      {super.key,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
      this.autofillHints,
      this.changeVisibility,
      this.isObscure = true});

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
          obscureText: password && !isObscure,
          enableSuggestions: password == true ? false : true,
          autocorrect: password == true ? false : true,
          decoration: InputDecoration(
            suffixIcon: password == true
                ? IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: changeVisibility)
                : null,
            contentPadding: const EdgeInsets.all(8),
            hintText: hint,
            hintStyle: kTextFieldTextStyle,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: kMediumGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: kPrimaryBlueColor,
                width: 2,
              ),
            ),
            // errorBorder: Styles.primaryRoundedOutlineInputBorder,
            // enabledBorder: Styles.primaryRoundedOutlineInputBorder,
            // disabledBorder: Styles.primaryRoundedOutlineInputBorder,
          ),
        ),
      ],
    );
  }
}
