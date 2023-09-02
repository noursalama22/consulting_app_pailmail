import 'package:flutter/cupertino.dart';

import '../../utils/helpers/constants.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({Key? key, required this.widgetName}) : super(key: key);
  final String widgetName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Cancel", style: buildAppBarTextStyle()),
        Text(
          widgetName,
          style: buildAppBarTextStyle(color: kBlackColor),
        ),
        Text(
          "Done",
          style: buildAppBarTextStyle(),
        ),
      ],
    );
  }
}
