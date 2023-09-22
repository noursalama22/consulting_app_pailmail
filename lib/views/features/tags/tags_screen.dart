import 'package:consulting_app_pailmail/providers/tag_provider.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/api_helpers/api_response.dart';
import '../../../core/utils/constants.dart';
import '../../../repositories/tag_repository.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  late TextEditingController _tagTextEditingController;
  List<Tags> tags = [Tags("all_tags".tr(), false)];

  // Map<String,dynamic> tags = {name:"all_tags".tr(),isPressed:false};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tagTextEditingController = TextEditingController();
    // Provider.of<TagProvider>(context).tagList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
            child: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 20.0.w, end: 20.0.w, bottom: 55.h),
                child: Consumer<TagProvider>(
                    builder: (context, tagProvider, child) {
                  if (tagProvider.tagList.status == ApiStatus.LOADING) {
                    return const CircularProgressIndicator();
                  }
                  if (tagProvider.tagList.status == ApiStatus.ERROR) {
                    return Text(tagProvider.tagList.message.toString());
                  } else {
                    return SingleChildScrollView(
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

                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tagProvider.tagList.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: InkWell(
                                        onTap: () {
                                          tagProvider.changeSelectedTag(
                                              selectedIndex: index);
                                          print("sssssss $index");
                                        },
                                        child: Text(
                                            "${tagProvider.tagList.data![index].name}"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
//                         child: Wrap(

      
//                 Wrap(

// //    runSpacing: 8,
//
//                           spacing: 6,
//                           children: [
//                             for (int i = 0; i < tags.length; i++) ...{
//                               CustomChip(
//                                 isPressed: tags[i].isPressed,
//                                 onPressed: i == 0
//                                     ? () {
//                                         tags[0].isPressed = !tags[0].isPressed;
//                                         for (int i = 1; i < tags.length; i++) {
//                                           tags[i].isPressed = false;
//                                         }
//                                         setState(() {});
//                                       }
//                                     : () {
//                                         tags[0].isPressed = false;
//                                         tags[i].isPressed = !tags[i].isPressed;
//                                         setState(() {
//                                           print(
//                                               "#${tagProvider.tagList.data![i].name}");
//                                         });
//                                       },
//                                 text: i == 0
//                                     ? tags[i].name
//                                     : "${tagProvider.tagList.data![i].name}",
//                               ),
//                             }
//                           ],
//                         ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),
                          //TODO : This contant diff btn add tag from show email under this tag!!
                          //TODO: Handle these 2 choice
                          TextField(
                            textInputAction: TextInputAction.next,
                            onSubmitted: (value) {
                              //TODO:ADD Tag
                              TagRepository()
                                  .createTag(_tagTextEditingController.text);
                              Provider.of<TagProvider>(context, listen: false)
                                  .getTagList();
                              tags.add(
                                  Tags(_tagTextEditingController.text, true));


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
                    );
                  }
                }))));


  }
}

class Tags {
  late String name;
  late bool isPressed;

  Tags(this.name, this.isPressed);
}
