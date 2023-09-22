import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../../models/statuses/status.dart';
import '../../../providers/status_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_date_container.dart';
import '../../widgets/custom_list_row_state.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  DateTime? _selectedDate = DateTime.now();

  late List<Status>? colors;
  clear() {
    Provider.of<StatusProvider>(context, listen: false).index = -1;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<StatusProvider>(context).allStatus.data;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              top: 20.0.h, start: 20.w, end: 20.w, bottom: 62.h),
          child: Column(
            children: [
              const CustomAppBar(
                widgetName: 'Filters',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ///Add State
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 19.0.w),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              //todo: apply clear filter
                              // clear();
                              Provider.of<StatusProvider>(context,
                                      listen: false)
                                  .index = -1;
                            });
                          },
                          child: Text(
                            "Clear Filter",
                            style: buildAppBarTextStyle(
                                color: kMediumGreyColor,
                                fontSizeController: 16,
                                letterSpacing: 0.15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    status == null
                        ? spinkit
                        : CustomListRowState(
                            statusList: status,
                            isStatus: true,
                            color: status,
                          ),
                  ],
                ),
              ),
              CustomDateContainer(
                title: 'From Date',
                selectedDate: _selectedDate!,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomDateContainer(
                title: 'To Date',
                selectedDate: _selectedDate!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // }
}
