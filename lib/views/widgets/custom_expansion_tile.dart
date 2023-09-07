import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  CustomExpansionTile({
    super.key,
    required this.orgName,
    required this.mailNumber,
    required this.children,
  });

  final String orgName;
  final String mailNumber;
  final List<Widget> children;
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
      shape: Border(),
      tilePadding: const EdgeInsetsDirectional.only(
        start: 16.0,
      ),
      onExpansionChanged: (bool expanded) {
        expandCollapse();
      },
      title: Text(
        widget.orgName,
        style: tileTextTitleStyle,
      ),
      trailing: Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !_customTileExpanded,
              child: Text(
                widget.mailNumber,
                style: tileTextNumberStyle,
              ),
            ),
            SizedBox(
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
