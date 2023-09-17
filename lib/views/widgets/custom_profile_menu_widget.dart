import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.edit,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function()? edit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kPrimaryBlueColor.withOpacity(0.1),
            ),
            child: Icon(icon, color: kPrimaryBlueColor),
          ),
          trailing: edit == null
              ? null
              : GestureDetector(
                  onTap: edit,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kYellowColor.withOpacity(0.1),
                    ),
                    child: Icon(Icons.edit, color: kYellowColor),
                  ),
                ),
          title: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.apply(color: kBlackColor)),
        ),
        Divider(),
      ],
    );
  }
}
