import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeButtons extends StatefulWidget {
  final Color color;
  final String title;
  final String img;

  final VoidCallback? onTap;
  const HomeButtons({
    Key? key,
    required this.color,
    required this.title,
    required this.img,
    this.onTap,
  }) : super(key: key);

  @override
  State<HomeButtons> createState() => _HomeButtonsState();
}

class _HomeButtonsState extends State<HomeButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 64.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Image.asset(
                widget.img,
                color: white,
              ),
            ),
            title: TextWidgets(
              text: widget.title,
              size: 22.sp,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
