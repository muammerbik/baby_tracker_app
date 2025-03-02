import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/feeding/view/feeding_view.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFeedListView extends StatefulWidget {
  const CustomFeedListView({super.key});

  @override
  State<CustomFeedListView> createState() => _CustomFeedListViewState();
}

class _CustomFeedListViewState extends State<CustomFeedListView> {
  final feedingViewModel = locator<FeedingViewModel>();

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    return Observer(
      builder: (context) => feedingViewModel.feedList.isNotEmpty
          ? ListView.builder(
              itemCount: feedingViewModel.feedList.length,
              itemBuilder: (context, index) {
                final list = feedingViewModel.feedList[index];
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
                    feedingViewModel.delete(list.id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigation.push(
                        page: FeedingView(feedingModel: list),
                      );
                      feedingViewModel.selectedFeed = list;
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        feedingIcon,
                                        height: 36.h,
                                        color: darkBlue,
                                      ),
                                      SizedBox(width: 3.w),
                                      TextWidgets(
                                        text: feeding,
                                        size: 18.sp,
                                        color: darkBlue,
                                      )
                                    ],
                                  ),
                                  TextWidgets(
                                    text: list.time,
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
                                    feedingNote,
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      feedingViewModel
                                          .updateSelectedIndex(index);
                                    });
                                  },
                                  icon: Icon(
                                    feedingViewModel.selectedIndex == index
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  )),
                            ),
                            if (feedingViewModel.selectedIndex == index)
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
            ),
    );
  }
}
