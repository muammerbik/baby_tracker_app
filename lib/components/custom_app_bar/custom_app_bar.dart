import 'package:baby_tracker/components/custom_text/text_widget.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baby_tracker/constants/app_strings.dart';

class CustomAppBarView extends StatefulWidget implements PreferredSizeWidget {
  final String? appBarTitle;
  final bool? centerTitle;
  final List<IconButton>? actionIcons;
  final Color? appBarColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Widget? customLeading;

  const CustomAppBarView({
    Key? key,
    this.appBarTitle,
    this.centerTitle,
    this.actionIcons,
    this.appBarColor,
    this.textColor,
    this.onTap,
    this.iconColor,
    this.customLeading, 
  }) : super(key: key);

  @override
  State<CustomAppBarView> createState() => _CustomAppBarViewState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarViewState extends State<CustomAppBarView> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: white,
      centerTitle: widget.centerTitle,
      backgroundColor: widget.appBarColor ?? white,
      leading: widget.customLeading ??
          IconButton(
            onPressed: () {
              Navigation.ofPop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: widget.iconColor ?? black,
            ),
          ),
      title: TextWidgets(
        text: widget.appBarTitle!,
        size: 27.sp,
        color: widget.textColor ?? black,
      ),
      actions: widget.actionIcons ?? [],
    );
  }
}
