import 'package:flutter/material.dart';

import '../../utils/helpers/constants.dart';

class CustomRoundedRectangleWidget extends StatelessWidget {
  final Widget child;
  const CustomRoundedRectangleWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: kLightGreyColor, width: 1)),
        child: child);
  }
}
