import 'package:consulting_app_pailmail/models/tags/tag.dart';
import 'package:consulting_app_pailmail/providers/tag_provider.dart';
import 'package:consulting_app_pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_app_bar.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_chip.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_mail_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helpers/api_helpers/api_response.dart';
import '../../../core/utils/constants.dart';
import '../../../repositories/tag_repository.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen(
      {Key? key, this.tags, this.navFromHome = false, this.selectedTag})
      : super(key: key);
  final List<Tag>? tags;
  final bool navFromHome;
  final int? selectedTag;
  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  late TextEditingController _tagTextEditingController;
  // List<Tags> tags = [Tags("all_tags".tr(), false)];

  // Map<String,dynamic> tags = {name:"all_tags".tr(),isPressed:false};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tagTextEditingController = TextEditingController();
    selectedTagsId.add(widget.selectedTag!);
    allTagPress = selectedTagsId.contains(-1);
    print("----------------------${selectedTagsId}");
    // Provider.of<TagProvider>(context).tagList;
  }

  List<int> selectedTagsId = [];
  late bool allTagPress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding:
          EdgeInsetsDirectional.only(start: 20.0.w, end: 20.0.w, bottom: 12.h),
      // child: Consumer<TagProvider>(
      //     builder: (context, tagProvider, child) {
      //   if (tagProvider.tagList.status == ApiStatus.LOADING) {
      //     return const CircularProgressIndicator();
      //   }
      //   if (tagProvider.tagList.status == ApiStatus.ERROR) {
      //     return Text(tagProvider.tagList.message.toString());
      //   } else {
      //     return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(
            widgetName: 'Tags',
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: Wrap(
              //TODO:Hnadle move to tag screen
              spacing: 6,
              children: [
                CustomChip(
                  text: "allTags".tr(),
                  onPressed: () {
                    //  allTagPress = !allTagPress;
                    //      setState(() {});
                    if (!selectedTagsId.contains(-1)) {
                      selectedTagsId.clear();
                      selectedTagsId.add(-1);
                      Provider.of<TagProvider>(context, listen: false)
                          .getTagWithMailList("all");
                    } else {}

                    setState(() {});
                  },
                  isPressed: selectedTagsId.contains(-1),
                ),
                for (int i = 0; i < widget.tags!.length; i++) ...{
                  CustomChip(
                      text: "${widget.tags![i].name}",
                      isPressed: selectedTagsId.contains(widget.tags![i].id),
                      // isPressed: widget.selectedTag == widget.tags![i].id,
                      onPressed: () {
                        //  allTagPress = !allTagPress;
                        // setState(() {});
                        if (selectedTagsId.contains(widget.tags![i].id)) {
                          selectedTagsId.remove(widget.tags![i].id);
                          Provider.of<TagProvider>(context, listen: false)
                              .getTagWithMailList("$selectedTagsId");
                        } else {
                          selectedTagsId.remove(-1);
                          selectedTagsId.add(widget.tags![i].id!);
                          Provider.of<TagProvider>(context, listen: false)
                              .getTagWithMailList("$selectedTagsId");
                          print(
                              "----------------------${selectedTagsId.length}");
                          print("----------------------${selectedTagsId[0]}");
                        }
                        setState(() {});
                      }),
                }
              ],
            ),
          ),

//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsetsDirectional.symmetric(
//                                 horizontal: 12, vertical: 12),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(
//                                 30,
//                               ),
//                             ),
//
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: tagProvider.tagList.data!.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(20),
//                                       child: InkWell(
//                                         onTap: () {
//                                           tagProvider.changeSelectedTag(
//                                               selectedIndex: index);
//                                           print("sssssss $index");
//                                         },
//                                         child: Text(
//                                             "${tagProvider.tagList.data![index].name}"),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
// //                         child: Wrap(
//
// //                 Wrap(
//
// // //    runSpacing: 8,
// //
// //                           spacing: 6,
// //                           children: [
// //                             for (int i = 0; i < tags.length; i++) ...{
// //                               CustomChip(
// //                                 isPressed: tags[i].isPressed,
// //                                 onPressed: i == 0
// //                                     ? () {
// //                                         tags[0].isPressed = !tags[0].isPressed;
// //                                         for (int i = 1; i < tags.length; i++) {
// //                                           tags[i].isPressed = false;
// //                                         }
// //                                         setState(() {});
// //                                       }
// //                                     : () {
// //                                         tags[0].isPressed = false;
// //                                         tags[i].isPressed = !tags[i].isPressed;
// //                                         setState(() {
// //                                           print(
// //                                               "#${tagProvider.tagList.data![i].name}");
// //                                         });
// //                                       },
// //                                 text: i == 0
// //                                     ? tags[i].name
// //                                     : "${tagProvider.tagList.data![i].name}",
// //                               ),
// //                             }
// //                           ],
// //                         ),
//                           ),

          const SizedBox(
            height: 12,
          ),
          //TODO : This contant diff btn add tag from show email under this tag!!
          //TODO: Handle these 2 choice
          !widget.navFromHome
              ? TextField(
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {
                    //TODO:ADD Tag
                    TagRepository().createTag(_tagTextEditingController.text);
                    Provider.of<TagProvider>(context, listen: false)
                        .getTagList();
                    // widget.tags.add(
                    //     Tags(_tagTextEditingController.text, true));

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
                )
              : Expanded(
                  child: Consumer<TagProvider>(
                    builder: (context, value, child) {
                      if (value.tagWithMailList.status == ApiStatus.LOADING) {
                        return Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.symmetric(vertical: 24),
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: ListTile(
                                  title: Text('Item number  as title'),
                                  subtitle: Text('Subtitle here'),
                                  trailing: Icon(
                                    Icons.ac_unit,
                                    size: 32,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (value.tagWithMailList.status ==
                          ApiStatus.ERROR) {
                        print(
                            "--------${value.tagWithMailList.message}------------");
                        return Text("Smth wrongm");
                      } else {
                        var mails = value.tagWithMailList.data!;
                        // var mails = value.tagWithMailList.data!;
                        if (mails!.isEmpty) {
                          return const Text(
                            "No mails",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          //  print("----------${mails!.length}");

                          return ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = mails[index].mails;
                              print("----------${data!.length}");
                              if (data!.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    child:
                                    return CustomMailContainer(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return InboxScreen(
                                              isDetails: true,
                                              mail: data[index],
                                            );
                                          },
                                        ));
                                      },
                                      organizationName:
                                          data![i].sender!.name ?? "",
                                      color: Color(int.parse(
                                          data[i].status!.color.toString())),
                                      date: data[i].archiveDate ?? "",
                                      description: data[i].description ?? "",
                                      images: data[i].attachments ?? [],
                                      tags: data[i].tags ?? [],
                                      subject: data[i].subject ?? "",
                                      endMargin: 8,
                                    );
                                  },
                                  itemCount: data!.length,
                                );

                                // for (int i = 0; i < data!.length; i++) {
                                //   print("/////$i");
                                //   return CustomMailContainer(
                                //     onTap: () {
                                //       Navigator.push(context, MaterialPageRoute(
                                //         builder: (context) {
                                //           return InboxScreen(
                                //             isDetails: true,
                                //             mail: data[index],
                                //           );
                                //         },
                                //       ));
                                //     },
                                //     organizationName: data![i].sender!.name ?? "",
                                //     color: Color(int.parse(
                                //         data[i].status!.color.toString())),
                                //     date: data[i].archiveDate ?? "",
                                //     description: data[i].description ?? "",
                                //     images: data[i].attachments ?? [],
                                //     tags: data[i].tags ?? [],
                                //     subject: data[i].subject ?? "",
                                //     endMargin: 8,
                                //   );
                                // }
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                            itemCount: mails.length,
                          );
                        }
                      }
                    },
                  ),
                ),
          //TODO: modify the visibility of textfield
        ],
      ),
    )));
  }
}

class Tags {
  late String name;
  late bool isPressed;

  Tags(this.name, this.isPressed);
}
