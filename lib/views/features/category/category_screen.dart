import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/providers/categories_provider.dart';
import 'package:consulting_app_pailmail/views/widgets/custom_list_row_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_app_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 45.h,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            top: 20.0.h, start: 20.w, end: 20.w, bottom: 62.h),
        child: Column(children: [
          ///app Bar
          const CustomAppBar(
            widgetName: 'Category',
          ),

          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Consumer<CategoriesProvider>(
                    builder: (BuildContext context, categoriesProvider,
                        Widget? child) {
                      if (categoriesProvider.allCategories.status ==
                          ApiStatus.LOADING) {
                        return const Center(
                          child: spinkit,
                        );
                      }
                      if (categoriesProvider.allCategories.status ==
                          ApiStatus.COMPLETED) {
                        if (categoriesProvider.allCategories.data!.isEmpty) {
                          return const Column(
                            children: [Icon(Icons.warning), Text("No Data")],
                          );
                        } else {
                          return CustomListRowState(
                            list: categoriesProvider.allCategories.data!,
                            isStatus: false,
                          );
                        }
                      }
//TODO: SnackBar showing
                      return Text(
                          "${categoriesProvider.allCategories.message}");
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
