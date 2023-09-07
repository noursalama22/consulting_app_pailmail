import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.children,
    required this.widgetOfTile,
    this.isIndexWidet = false,
    this.mailNumber,
  });

  final List<Widget> children;
  final Widget widgetOfTile;
  final bool? isIndexWidet;
  final String? mailNumber;

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
        padding: widget.isIndexWidet == false
            ? EdgeInsetsDirectional.only(end: 14.h)
            : EdgeInsetsDirectional.only(end: 0.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !_customTileExpanded,
              child: widget.isIndexWidet == false
                  ? Text(
                      widget.mailNumber ?? '',
                      style: buildAppBarTextStyle(),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              width: 6,
            ),
            Icon(
              _customTileExpanded
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.arrow_forward_ios_rounded,
              size: _customTileExpanded ? 32 : 18,
              // weight: 12,
            ),
          ],
        ),
      ),
      children: widget.children,
    );
  }
}
