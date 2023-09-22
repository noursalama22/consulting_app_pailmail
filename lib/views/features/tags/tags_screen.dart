import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/providers/tag_provider.dart';
import 'package:consulting_app_pailmail/repositories/tag_repository.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_app_bar.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_chip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../../models/tags/tag.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  late TextEditingController _tagTextEditingController;
  late Tag _tag;
  late TagRepository tagRep;

  // List<Tag> tags = [Tag("all_tags".tr(), false)];

  // Map<String,dynamic> tags = {name:"all_tags".tr(),isPressed:false};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tagTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tagTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Add red content "The unselected will searched And deleted if there is no mail Has the tag"
    return Scaffold(
        //TODO: Remove safe area
        body: Consumer<TagProvider>(builder: (_, tagProvider, __) {
      if (tagProvider.tagList.status == ApiStatus.LOADING) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (tagProvider.tagList.status == ApiStatus.ERROR) {
        return Center(
          child: Text('${tagProvider.tagList.message}'),
        );
      }
      return Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                start: 20.0.w, end: 20.0.w, bottom: 55.h, top: 24),
            child: Column(
              children: [
                const CustomAppBar(
                  widgetName: 'Tags',
                ),
                Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tagProvider.tagList.data!.length,
                      itemBuilder: (context, index) {
                        Tag tag = tagProvider.tagList.data![index];
                        return Text('${tag.name}');
                      },
                    )
//                 Wrap(
// //    runSpacing: 8,
//                   spacing: 6,
//                   children: [
//                     for (int i = 0; i < tags.length; i++) ...{
//                       CustomChip(
//                         isPressed: tags[i].isPressed,
//                         onPressed: i == 0
//                             ? () {
//                                 tags[0].isPressed = !tags[0].isPressed;
                    //                                   tags[i].isPressed = false;
//                                 }
//                                 setState(() {});
//                               }
//                             : () {
//                                 tags[0].isPressed = false;
//                                 tags[i].isPressed = !tags[i].isPressed;
//                                 setState(() {});
//                               },
//                         text: i == 0 ? tags[i].name : "#${tags[i].name}",
//                       ),
//                     }
//                   ],
// //                   [
// //                     CustomChip(
// //                       text: "all_tags".tr(),
// //                     ),
// //                     CustomChip(
// //                       text: '#Urgent',
// //                     ),
// //                     CustomChip(
// //                       text: '#Egyptian Military',
// //                     ),
// //                     CustomChip(
// //                       text: '#New',
// //                     ),
// // // onSelected: (sel) {},
// // // selected: true,
// // // selectedColor: kLightBlueColor,
// // //   color: MaterialStateColor.resolveWith((states) {
// // //     if (states.contains(MaterialState.selected)) {
// // //       return kLightBlueColor;
// // //     }
// // //     return kLightGreyColor;
// // //
// //                   ],
//                 ),

                    ),
                // CustomTextField(
                //   controller: _tagTextEditingController,
                //   hintText: 'Add New Tag…',
                //   customFontSize: 14,
                //   //TODO: Create color
                //   hintColor: Color(0xFFC4C4C4),
                // ),
                SizedBox(
                  height: 12,
                ),
                //TODO : This contant diff btn add tag from show email under this tag!!
                //TODO: Handle these 2 choice
                TextField(
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {
                    //TODO:ADD Tag
                    // tags.add(Tag(_tagTextEditingController.text, true));
                    value = _tagTextEditingController.text;
                    tagRep = TagRepository();
                    // tagRep.createTag(value);
                    _tag = Provider.of<TagProvider>(context, listen: false)
                        .getTagList();
                    _tagTextEditingController.clear();
                    setState(() {});
                  },
                  controller: _tagTextEditingController,
                  keyboardType: TextInputType.text,
                  //TODO :Create new color
                  style: const TextStyle(color: Color(0xff707070)),
                  cursorColor: const Color(0xff707070),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    hintText: "Add New Tag…",
                    hintStyle: buildAppBarTextStyle(
                        fontSizeController: 14,
                        color: const Color(0xFFC4C4C4),
                        //TODO : Check below color !!!!!!
                        // color: const Color(0xffafafaf),
                        letterSpacing: 0.15),
                  ),
                ),
                //TODO: modify the visibility of textfield
              ],
            ),
          ),
        ),
      );
    }));
  }
}

// class Tag {
//   late String name;
//   late bool isPressed;
//
//   Tag(this.name, this.isPressed);
// }
