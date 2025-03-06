// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:baby_tracker/components/custom_text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_tracker/constants/app_strings.dart';

class CustomSettingsButton extends StatefulWidget {
  final Color? buttonColor;
  final String leadingIcon;
  final Color? textColor;

  final double? height;
  final String title;
  final double? fontSize;
  final Color? iconColor;
  const CustomSettingsButton({
    Key? key,
    this.buttonColor,
    required this.leadingIcon,
    this.textColor,
    this.height,
    required this.title,
    this.fontSize,
    this.iconColor,
  }) : super(key: key);

  @override
  State<CustomSettingsButton> createState() => _CustomSettingsButtonState();
}

class _CustomSettingsButtonState extends State<CustomSettingsButton> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        child: Container(
          height: widget.height ?? 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36.r),
            color: widget.buttonColor ?? darkWhite,
          ),
          child: ListTile(
            leading: Image.asset(
              widget.leadingIcon,
              color: widget.textColor ?? black,
            ),
            title: TextWidgets(
              text: widget.title,
              size: widget.fontSize ?? 16.sp,
              color: widget.textColor ?? black,
              textAlign: TextAlign.start,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: widget.iconColor ?? black,
            ),
          ),
        ),
      ),
    );
  }
}
