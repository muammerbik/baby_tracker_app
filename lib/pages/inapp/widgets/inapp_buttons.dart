// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_tracker/constants/app_strings.dart';


class CustomInAppButtonWidget extends StatelessWidget {
  final String premiumTime;
  final String premiumMoney;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomInAppButtonWidget({
    Key? key,
    required this.premiumTime,
    required this.premiumMoney,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        child: Container(
          width: double.infinity,
          height: 64.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(70.r),
            border: Border.all(
              color: isSelected ? btnBlue : Colors.transparent,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidgets(
                  text: premiumTime,
                  size: 18.sp,
                  color: Colors.black,
                ),
                TextWidgets(
                  text: premiumMoney,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
