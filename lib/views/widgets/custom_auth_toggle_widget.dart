import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomAuthToggleWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color fontColor;
  const CustomAuthToggleWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 80,
        height: 40,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: Row(
              children: [
                Spacer(),
                Text(
                  text,
                  style: TextStyle(
                    color: fontColor,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
