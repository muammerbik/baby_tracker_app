import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiaperChangeColumn extends StatefulWidget {
  const DiaperChangeColumn({Key? key}) : super(key: key);

  @override
  State<DiaperChangeColumn> createState() => _DiaperChangeColumnState();
}

class _DiaperChangeColumnState extends State<DiaperChangeColumn> {
  final diaperViewmodel = locator<DiaperViewModel>();

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    return Observer(
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidgets(
              text: diaperStatus,
              size: 15,
              color: black,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: diaperStatusRow(DiaperStatus.Wet, "wett.png", "Wet"),
            ),
            diaperStatusRow(DiaperStatus.Dirty, "dirtyy.png", "Dirty"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: diaperStatusRow(DiaperStatus.Mixed, "mixedd.png", "Mixed"),
            ),
            diaperStatusRow(DiaperStatus.Dry, "dryy.png", "Dry"),
          ],
        ),
      ),
    );
  }

  Widget diaperStatusRow(DiaperStatus status, String imagePath, String text) {
    bool isSelected = diaperViewmodel.selectedStatus == status;

    return Observer(
      builder: (context) => InkWell(
        onTap: () async {
          diaperViewmodel.selectedStatus = isSelected ? null : status;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                  isSelected
                      ? "assets/images/$imagePath"
                      : "assets/images/$imagePath",
                  height: 24.h,
                  color: isSelected ? null : diaperColor),
            ),
            SizedBox(
              width: 8.w,
            ),
            TextWidgets(
              text: text,
              size: 14.sp,
              color: isSelected ? darkBlue : lightGrey,
            ),
          ],
        ),
      ),
    );
  }

  String getDiaperText(DiaperStatus status) {
    switch (status) {
      case DiaperStatus.Wet:
        return "Wet";
      case DiaperStatus.Dirty:
        return "Dirty";
      case DiaperStatus.Mixed:
        return "Mixed";
      case DiaperStatus.Dry:
        return "Dry";
    }
  }
}
