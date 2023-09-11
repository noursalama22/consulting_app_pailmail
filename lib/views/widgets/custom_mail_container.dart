import 'package:consulting_app_pailmail/utils/helpers/constants.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_photo_container.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_status_container.dart';
import 'package:flutter/material.dart';

class CustomMailContainer extends StatefulWidget {
  const CustomMailContainer(
      {Key? key,
      required this.organizationName,
      required this.date,
      required this.subject,
      required this.description,
      required this.tags,
      required this.images,
      required this.color,
      this.endMargin = 0,
      required this.onTap})
      : super(key: key);
  final String organizationName;
  final String date;
  final String subject;
  final String description;
  final List<String> tags;
  final List<String> images;
  final Color color;
  final double endMargin;
  final void Function() onTap;

  @override
  State<CustomMailContainer> createState() => _CustomMailContainerState();
}

class _CustomMailContainerState extends State<CustomMailContainer> {
  @override
  Widget build(BuildContext context) {
    //TODO : handel text color is blue if the message is not readed yet
    return Container(
      margin: EdgeInsetsDirectional.only(
        bottom: widget.endMargin,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomStatusContainer(
                            color: widget.color,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.organizationName,
                                style:
                                    tileTextTitleStyle.copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.date,
                          style: tileTextNumberStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: Text(
                    widget.subject,
                    style: tileTextTitleStyle.copyWith(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: Text(
                    widget.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        const TextStyle(fontSize: 14, color: kGreyWhiteColor),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //TODO : add tags
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: widget.tags.length == 0
                      ? SizedBox()
                      : Wrap(children: [
                          for (int i = 0; i < widget.tags.length; i++) ...{
                            Text(
                              "#${widget.tags[i]}",
                              style: tagsTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          }
                        ]),
                ),
                //TODO : get images from constuctor
                const SizedBox(
                  height: 6,
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.0),
                  child: Row(
                    children: [
                      //TODO: Add Gesture detoctor
                      CustomPhotoContainer(
                        raduis: 36,
                        image: 'assets/images/user_photo.png',
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CustomPhotoContainer(
                        raduis: 36,
                        image: 'assets/images/user_photo.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
