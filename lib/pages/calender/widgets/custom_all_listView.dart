import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/calender/viewmodel/calender_viewmodel.dart';
import 'package:baby_tracker/pages/diaper_change/view/diaper_change_view.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:baby_tracker/pages/feeding/view/feeding_view.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:baby_tracker/pages/sleep/view/sleep_view.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAllListView extends StatefulWidget {
  const CustomAllListView({super.key});

  @override
  State<CustomAllListView> createState() => _CustomAllListViewState();
}

class _CustomAllListViewState extends State<CustomAllListView> {
  final calenderViewModel = locator<CalenderViewModel>();
  final feedingViewModel = locator<FeedingViewModel>();
  final sleepViewModel = locator<SleepViewModel>();
  final diaperViewModel = locator.get<DiaperViewModel>();

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    return Observer(
      builder: (context) => Center(
        child: calenderViewModel.mergedList.isNotEmpty
            ? ListView.builder(
                itemCount: calenderViewModel.mergedList.length,
                itemBuilder: (context, index) {
                  final item = calenderViewModel.mergedList[index];
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Row(
                      children: [
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
                      ],
                    ),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      if (item.type == "feeding") {
                        feedingViewModel.delete(item.id);
                      } else if (item.type == "diaper") {
                        diaperViewModel.delete(item.id);
                      } else {
                        sleepViewModel.delete(item.id);
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (item.type == "feeding") {
                          Navigation.push(
                            page: FeedingView(
                              feedingModel: feedingViewModel.getItem(item.id),
                            ),
                          );

                          feedingViewModel.selectedFeed =
                              feedingViewModel.feedList[index];
                        } else if (item.type == "diaper") {
                          Navigation.push(
                            page: DiaperChangeView(
                              diaperChangeModel:
                                  diaperViewModel.getItemDiaper(item.id),
                            ),
                          );

                          diaperViewModel.selectedDiaper =
                              diaperViewModel.diaperList[index];
                        } else {
                          Navigation.push(
                            page: SleepView(
                              sleepModel: sleepViewModel.getItemSlep(item.id),
                            ),
                          );

                          sleepViewModel.selectedSlep =
                              sleepViewModel.sleepList[index];
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          item.iconPath,
                                          height: 40.h,
                                          color: darkBlue,
                                        ),
                                        SizedBox(width: 5.w),
                                        TextWidgets(
                                          text: item.category,
                                          size: 18.sp,
                                          color: darkBlue,
                                        )
                                      ],
                                    ),
                                    TextWidgets(
                                      text: item.date,
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
                                      calenderViewModel.capitalizeWithSuffix(
                                          item.type, notee),
                                      style: TextStyle(fontSize: 20.sp),
                                    )
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        calenderViewModel
                                            .updateSelectedIndex(index);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    calenderViewModel.allSelectedIndex == index
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                ),
                              ),
                              if (calenderViewModel.allSelectedIndex == index)
                                Observer(
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 12.h),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        item.note,
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
              ),
      ),
    );
  }
}
