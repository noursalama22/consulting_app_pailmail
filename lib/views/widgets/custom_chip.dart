import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  CustomChip({
    super.key,
    required this.text,
  });
  final String text;
  bool isSelected = false;
  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return RawChip(
      onSelected: (selected) {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      label: Text(
        widget.text,
      ),
      backgroundColor: widget.isSelected ? kLightBlueColor : kLightGreyColor,
      labelStyle: tileTextNumberStyle.copyWith(
        color: widget.isSelected ? Colors.white : kDarkGreyColor,
      ),
    );
  }
}
