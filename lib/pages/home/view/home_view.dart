import 'dart:io';
import 'package:baby_tracker/companents/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/calender/view/calender_view.dart';
import 'package:baby_tracker/pages/diaper_change/view/diaper_change_view.dart';
import 'package:baby_tracker/pages/feeding/view/feeding_view.dart';
import 'package:baby_tracker/pages/home/widgets/home_buttons.dart';
import 'package:baby_tracker/pages/information/view/information_view.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:baby_tracker/pages/settings/view/settings_view.dart';
import 'package:baby_tracker/pages/sleep/view/sleep_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final informationViewModel = locator<InformationViewModel>();

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    final String? localImagePath = informationViewModel.imageFile?.path;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarView(
        appBarTitle: "",
        customLeading: IconButton(
          onPressed: () {
            Navigation.push(
              page: const SettingsView(),
            );
          },
          icon: const Icon(Icons.settings),
        ),
        actionIcons: [
          IconButton(
            onPressed: () {
              Navigation.push(
                page: const CalenderView(),
              );
            },
            icon: const Icon(Icons.calendar_month),
          )
        ],
      ),
      body: Observer(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: GestureDetector(
                onTap: () {
                  Navigation.push(
                    page: const InformationView(),
                  );
                },
                child: Container(
                  width: 124.w,
                  height: 124.w,
                  decoration: ShapeDecoration(
                    image: localImagePath != null
                        ? DecorationImage(
                            image: FileImage(
                              File(localImagePath),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                    shape: const OvalBorder(
                      side: BorderSide(width: 1, color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigation.push(
                  page: const InformationView(),
                );
              },
              child: TextWidgets(
                text: editProfile,
                size: 15.sp,
                color: darkBlue,
              ),
            ),
            Observer(
              builder: (context) => TextWidgets(
                  text: informationViewModel.nameController.text,
                  size: 25.sp,
                  color: purple),
            ),
            Observer(
              builder: (context) => TextWidgets(
                text: informationViewModel.calculateAge(
                    informationViewModel.birthDateController.text),
                size: 14.sp,
                color: black,
                fontWeight: FontWeight.w400,
              ),
            ),
            HomeButtons(
              color: darkPurple,
              title: feeding,
              img: feedingIcon,
              onTap: () {
                Navigation.push(
                  page: const FeedingView(),
                );
              },
            ),
            HomeButtons(
              color: lightblue,
              title: diaper,
              img: diaperIcon,
              onTap: () {
                Navigation.push(
                  page: const DiaperChangeView(),
                );
              },
            ),
            HomeButtons(
              color: darkBlue,
              title: sleep,
              img: sleepIcon,
              onTap: () {
                Navigation.push(
                  page: const SleepView(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
