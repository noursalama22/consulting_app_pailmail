import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

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
