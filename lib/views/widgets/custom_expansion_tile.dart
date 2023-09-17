import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.children,
    required this.widgetOfTile,
    this.isIndexWidet = false,
    this.mailNumber,
    this.isExpanded = true,
  });

  final List<Widget> children;
  final Widget widgetOfTile;
  final bool isIndexWidet;
  final String? mailNumber;
  final bool isExpanded;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;

  void expandCollapse() {
    setState(() {
      _customTileExpanded = !_customTileExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: !widget.isExpanded,
      childrenPadding: EdgeInsetsDirectional.zero,
      shape: const Border(),
      tilePadding: widget.isIndexWidet == false
          ? EdgeInsetsDirectional.only(
              start: 16.0.h,
            )
          : const EdgeInsetsDirectional.only(start: 0),
      onExpansionChanged: (bool expanded) async {
        expandCollapse();
      },
      title: widget.widgetOfTile,
      trailing: Padding(
        padding: !widget.isIndexWidet
            ? EdgeInsetsDirectional.only(end: 14.h)
            : EdgeInsetsDirectional.only(end: 0.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !widget.isExpanded || !_customTileExpanded,
              child: Text(
                widget.mailNumber ?? '',
                //TODO : Style
                style: buildAppBarTextStyle(
                    color: kMediumGreyColor,
                    fontSizeController: 14,
                    letterSpacing: 0.15),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            widget.isExpanded
                ? Icon(
                    _customTileExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.arrow_forward_ios_rounded,
                    size: _customTileExpanded ? 32 : 18,
                    color:
                        _customTileExpanded ? kLightBlueColor : kDarkGreyColor,
                    // weight: 12,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      children: widget.children,
    );
  }
}
