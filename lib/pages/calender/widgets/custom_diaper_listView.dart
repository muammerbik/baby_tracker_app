
import 'package:baby_tracker/components/custom_text/text_widget.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/diaper_change/view/diaper_change_view.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDiaperListView extends StatefulWidget {
  const CustomDiaperListView({super.key});

  @override
  State<CustomDiaperListView> createState() => _CustomDiaperListViewState();
}

class _CustomDiaperListViewState extends State<CustomDiaperListView> {
  final diaperViewModel = locator.get<DiaperViewModel>();

  @override
  Widget build(BuildContext context) {
  
    return Observer(
      builder: (context) => diaperViewModel.diaperList.isNotEmpty
          ? ListView.builder(
              itemCount: diaperViewModel.diaperList.length,
              itemBuilder: (context, index) {
                final list = diaperViewModel.diaperList[index];

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
                      ),
                    ],
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    diaperViewModel.delete(list.id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigation.push(
                        page: DiaperChangeView(
                          diaperChangeModel: list,
                        ),
                      );
                      diaperViewModel.selectedDiaper = list;
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
                                        diaperIcon,
                                        height: 30.h,
                                        color: darkBlue,
                                      ),
                                      SizedBox(width: 8.w),
                                      TextWidgets(
                                        text: diaper,
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
                                    diaperNote,
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      diaperViewModel
                                          .updateSelectedIndex(index);
                                    });
                                  },
                                  icon: Icon(
                                    diaperViewModel.diaperSelectedIndex == index
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  )),
                            ),
                            if (diaperViewModel.diaperSelectedIndex == index)
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

  DiaperStatus getDiaperStatusFromString(String statusString) {
    switch (statusString) {
      case '0':
        return DiaperStatus.Wet;
      case '1':
        return DiaperStatus.Dirty;
      case '2':
        return DiaperStatus.Mixed;
      case '3':
        return DiaperStatus.Dry;
      default:
        return DiaperStatus.Wet;
    }
  }
}
