import 'dart:io';

import 'package:consulting_app_pailmail/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/add_activity.dart';
import '../../utils/helpers/constants.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_expansion_tile.dart';
import '../widgets/custom_text_field.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  DateTime? _selectedDate = DateTime.now();
  late List<AddActivity> addActivity;
  late TextEditingController senderController;
  late TextEditingController addNewActivityController;
  late TextEditingController addDecisionController;
  late TextEditingController phoneController;
  late TextEditingController archiveController;
  late TextEditingController tileOfMailController;
  late TextEditingController dateController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    addActivity = [];
    addNewActivityController = TextEditingController();
    senderController = TextEditingController();
    addDecisionController = TextEditingController();
    archiveController = TextEditingController();
    dateController = TextEditingController();
    tileOfMailController = TextEditingController();
    phoneController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    addNewActivityController.dispose();
    senderController.dispose();
    addDecisionController.dispose();
    archiveController.dispose();
    dateController.dispose();
    tileOfMailController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: 20.0.w, end: 20.0.w, bottom: 16.h),
        // start: 20.0.w, end: 20.0.w, top: 24.h, bottom: 16.h),
        child: Column(children: [
          ///App Bar
          const CustomAppBar(widgetName: "New Inbox", bottomPadding: 16),
          Expanded(
            child: ListView(
              //TODO :content padding not padding for all column
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                ///Big Container
                CustomContainer(
                    childContainer: Column(
                  children: [
                    ///Upper Part(Name)

                    CustomTextField(
                      withoutPrefix: false,
                      withoutSuffix: false,
                      hintText: 'Sender',
                      customFontSize: 16,
                      controller: senderController,
                      icon: Icons.perm_identity,
                    ),
                    CustomTextField(
                      textInputType: TextInputType.number,
                      withoutPrefix: false,
                      hintText: 'Mobile',
                      customFontSize: 16,
                      controller: senderController,
                      icon: Icons.phone_android_outlined,
                    ),

                    // buildDivider(),

                    ///Lower part (category)
                    Padding(
                      padding: EdgeInsets.only(
                          top: 16.0.h, bottom: 18.h, left: 11.w, right: 11.w),
                      child: Row(
                        children: [
                          Text("Category",
                              style: buildAppBarTextStyle(
                                  color: kBlackColor,
                                  letterSpacing: 0.15,
                                  fontSizeController: 16)),
                          const Spacer(),
                          Text("Other",
                              style: buildAppBarTextStyle(
                                  color: kDarkGreyColor,
                                  letterSpacing: 0.15,
                                  fontSizeController: 14)),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: kDarkGreyColor,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 15.h,
                ),

                ///Title of mail and description
                CustomContainer(
                    childContainer: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: 'Tile of mail',
                      customFontSize: 20,
                      withoutPrefix: true,
                      controller: tileOfMailController,
                    ),
                    buildDivider(),
                    CustomTextField(
                      hintText: 'Description',
                      customFontSize: 14,
                      textInputType: TextInputType.multiline,
                      // للسماح بإدخال أكثر من سطر
                      maxLine: null,
                      controller: descriptionController,
                    ),
                  ],
                )),
                SizedBox(
                  height: 29.h,
                ),

                ///date calender
                CustomContainer(
                    childContainer: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(children: [
                    CustomExpansionTile(
                      isIndexWidet: true,
                      widgetOfTile: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: kRedColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: buildAppBarTextStyle(
                                        color: kBlackColor,
                                        letterSpacing: 0.15,
                                        fontSizeController: 16),
                                  ),
                                  Text(
                                    "$_selectedDate".split(" ")[0],
                                    style: buildAppBarTextStyle(
                                        letterSpacing: 0.15,
                                        fontSizeController: 12),
                                  ),
                                  buildDivider()
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        buildDivider(),
                        Column(
                          children: [buildCalendarDatePicker()],
                        ),
                      ],
                    ),
                    buildDivider(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.archive_outlined,
                          color: kDarkGreyColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 9.w,
                        ),
                        Expanded(
                          // توسيع الحقل ليحتل العرض المتاح
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Archive Number",
                                style: buildAppBarTextStyle(
                                    color: kBlackColor,
                                    letterSpacing: 0.15,
                                    fontSizeController: 16),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // استخدم العرض الكامل للشاشة - (عرض الأيقونة + 9 وحدة)
                                child: CustomTextField(
                                  withoutPrefix: true,
                                  paddingHor: 0,
                                  hintText: '2021/2022',
                                  maxLine: null,
                                  customFontSize: 16.0,
                                  controller: archiveController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                )),
                SizedBox(
                  height: 19.h,
                ),

                ///Tags it will open bottom Sheet
                buildListTile(
                  icon: Icons.tag_rounded,
                  widget: Text(
                    "Tags",
                    style: buildAppBarTextStyle(
                        color: const Color(0xff272727),
                        letterSpacing: 0.15,
                        fontSizeController: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),

                /// Categories it will view categories screen
                buildListTile(
                  icon: Icons.forward_to_inbox,
                  widget: const Row(
                    children: [
                      CustomContainer(
                        isInBox: true,
                        backgroundColor: Color(0xffFA3A57),
                        childContainer: Text(
                          "Inbox",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),

                ///Add description
                CustomContainer(
                    childContainer: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Decision",
                        style: buildAppBarTextStyle(
                            color: kBlackColor, letterSpacing: 0.15),
                      ),
                      CustomTextField(
                          paddingHor: 0,
                          hintText: "Add Decision…",
                          customFontSize: 14,
                          controller: addDecisionController),
                    ],
                  ),
                )),
                SizedBox(
                  height: 16.h,
                ),

                ///Pick Image
                CustomContainer(
                    childContainer: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _showImageSourceOptions;
                                  },
                                  child: Text(
                                    "Add Image",
                                    style: buildAppBarTextStyle(
                                        fontSizeController: 16.sp,
                                        letterSpacing: 0.15),
                                  ),
                                ),
                                pickedMultiImage == null ||
                                        pickedMultiImage.isEmpty
                                    ? const SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          setState(() {});
                                          pickedMultiImage.clear();
                                        },
                                        child: Text(
                                          "Clear All",
                                          style: buildAppBarTextStyle(
                                              fontSizeController: 16.sp,
                                              letterSpacing: 0.15),
                                        ),
                                      ),
                              ],
                            ),

                            ///view Images
                            pickedMultiImage == null || pickedMultiImage.isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: 16.h,
                                  ),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 12),
                              itemBuilder: (BuildContext context, int index) {
                                return viewImages(index);
                              },
                              itemCount: pickedMultiImage.length,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
                  child: CustomExpansionTile(
                      mailNumber:
                          addActivity.isNotEmpty ? "${addActivity.length}" : "",
                      widgetOfTile: Text(
                        "Activity",
                        style: buildAppBarTextStyle(
                            letterSpacing: 0.15,
                            fontSizeController: 20.sp,
                            color: kBlackColor),
                      ),
                      isIndexWidet: false,
                      children: [
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: addActivity.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0.h),
                              child: CustomContainer(
                                childContainer: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text("Mohammed"),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(addActivity[index].activityName),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text("${addActivity[index].currentTime}"
                                          .split(" ")[0])
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 12.h,
                            );
                          },
                        )
                      ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomContainer(
                  isInBox: true,
                  backgroundColor: kLightGreyColor,
                  childContainer: CustomTextField(
                      suffixIcon: Icons.send_outlined,
                      withoutPrefix: false,
                      suffixFunction: () {
                        print("sss");
                        print("${addNewActivityController.text} rrr");
                        if (addNewActivityController.text != null &&
                            addNewActivityController.text.isNotEmpty) {
                          setState(() {
                            addActivity.add(AddActivity(
                                activityName: addNewActivityController.text,
                                currentTime: DateTime.now()));
                          });
                          addNewActivityController.clear();
                        }
                      },
                      withoutSuffix: false,
                      maxLine: null,
                      icon: Icons.person,
                      hintText: "Add new Activity ...",
                      customFontSize: 14.sp,
                      controller: addNewActivityController),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  Stack viewImages(int index) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle),
          child: pickedMultiImage != null
              ? Image.file(
                  File(pickedMultiImage[index]!.path),
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
        ),

        ///Delete of all images

        PositionedDirectional(
          start: -10,
          top: -10,
          child: InkWell(
            onTap: () {
              setState(() {});
              pickedMultiImage.removeAt(index);
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.shade100,
              child: const Icon(
                Icons.delete,
                size: 20,
                color: kRedColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  CalendarDatePicker buildCalendarDatePicker() {
    return CalendarDatePicker(
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      onDateChanged: (value) {
        // _selectedDate = value;
        if (_selectedDate != null && value != _selectedDate) {
          setState(() {
            _selectedDate = value;
          });
        }
      },
    );
  }

  CustomContainer buildListTile(
      {required IconData icon, required Widget widget}) {
    return CustomContainer(
      childContainer: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.0),
          child: Icon(
            icon,
            size: 20,
            color: kDarkGreyColor,
          ),
        ),
        title: widget,
        trailing: const Padding(
          padding: EdgeInsetsDirectional.only(end: 17.0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: kMediumGreyColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 12,
      thickness: 1.5,
      indent: 17.w,
      endIndent: 16.w,
    );
  }

  void get _showImageSourceOptions {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.h),
            child: Column(
              children: [
                const CustomAppBar(widgetName: "Add Image"),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await _pickImage(ImageSource.camera);
                        },
                        child: ImagesContainers(
                            color: kDarkGreyColor,
                            icon: Icons.camera_alt,
                            iconColor: kLightGreyColor,
                            text: 'Camera'),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      InkWell(
                          onTap: () async {
                            await _pickMultiImage;
                          },
                          child: ImagesContainers(
                              color: kLightGreyColor,
                              icon: Icons.camera,
                              fontColor: kDarkGreyColor,
                              iconColor: kDarkGreyColor,
                              text: 'Gallery')),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container ImagesContainers(
      {required Color color,
      required IconData icon,
      required String text,
      Color fontColor = Colors.white,
      required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: color,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            text,
            style: TextStyle(color: fontColor),
          ),
        ],
      ),
    );
  }

  XFile? pickedImage;
  ImagePicker imagePick = ImagePicker();
  List<XFile?> pickedMultiImage = [];

  Future<dynamic> _pickImage(ImageSource imageSource) async {
    XFile? image = await imagePick.pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        pickedImage = image;
      });
    }
  }

  Future<void> get _pickMultiImage async {
    List<XFile?> images = await imagePick.pickMultiImage();
    if (images != null) {
      setState(() {
        pickedMultiImage.addAll(images);
      });
    }
  }
}
