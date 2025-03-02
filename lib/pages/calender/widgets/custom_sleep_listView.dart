import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/sleep/view/sleep_view.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSleepListView extends StatefulWidget {
  const CustomSleepListView({super.key});

  @override
  State<CustomSleepListView> createState() => _CustomSleepListViewState();
}

class _CustomSleepListViewState extends State<CustomSleepListView> {
  final sleepViewModel = locator<SleepViewModel>();

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    return sleepViewModel.sleepList.isNotEmpty
        ? ListView.builder(
            itemCount: sleepViewModel.sleepList.length,
            itemBuilder: (context, index) {
              final list = sleepViewModel.sleepList[index];
              return Dismissible(
                direction: DismissDirection.startToEnd,
                background: Row(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Icon(
                      Icons.delete,
                      color: red,
                      size: 30.sp,
                    ),
                  ),
                  TextWidgets(
                    text: delete,
                    size: 20.sp,
                    color: black,
                  )
                ]),
                key: UniqueKey(),
                onDismissed: (direction) {
                  sleepViewModel.delete(list.id);
                },
                child: GestureDetector(
                  onTap: () {
                    Navigation.push(
                      page: SleepView(sleepModel: list),
                    );
                    sleepViewModel.selectedSlep = list;
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: darkWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      sleepIcon,
                                      height: 40.h,
                                      color: darkBlue,
                                    ),
                                    SizedBox(width: 5.w),
                                    TextWidgets(
                                      text: sleep,
                                      size: 18.sp,
                                      color: darkBlue,
                                    ),
                                  ],
                                ),
                                TextWidgets(
                                  text: list.wakeUp,
                                  size: 16.sp,
                                  color: black,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.only(left: 12.w),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  calenderImg,
                                  color: orange.shade800,
                                  height: 42.h,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  sleepNote,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    sleepViewModel.updateSelectedIndex(index);
                                  });
                                },
                                icon: Icon(
                                  sleepViewModel.sleepSelectIndex == index
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                )),
                          ),
                          if (sleepViewModel.sleepSelectIndex == index)
                            Observer(
                              builder: (context) => Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 12.h),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    list.note,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: TextWidgets(
              text: diaperIsempty,
              size: 16.sp,
              color: black,
              fontWeight: FontWeight.w500,
            ),
          );
  }
}
