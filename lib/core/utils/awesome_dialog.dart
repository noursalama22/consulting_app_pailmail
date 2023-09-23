import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

mixin AwesomeDialogMixin {
  AwesomeDialog buildSuccessDialog(
    BuildContext context,
    String title,
    String desc,
  ) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      borderSide: BorderSide(color: kGreenColor, width: 1),
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      title: title,
      desc: desc,
      // btnCancelOnPress: () {},
      autoDismiss: true,
      autoHide: const Duration(seconds: 2),

      // btnOkOnPress: () {},
      // btnOk: SizedBox(),
    );
  }

  AwesomeDialog buildWarningDialog(
      BuildContext context, String title, Function() ok) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: BorderSide(color: kYellowColor, width: 1),
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      title: title,
      desc: 'Are you sure to $title?',
      showCloseIcon: false,
      btnCancelOnPress: () {},
      btnOkOnPress: ok,
    );
  }
}
