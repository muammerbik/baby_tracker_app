// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:baby_tracker/companents/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/companents/custom_button/custom_elevated_button.dart';
import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/companents/custom_text_form_field/custom_text_form_field.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/data/models/sleeep_model.dart';
import 'package:flutter/material.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SleepView extends StatefulWidget {
  final SleepModel? sleepModel;
  const SleepView({
    Key? key,
    this.sleepModel,
  }) : super(key: key);

  @override
  State<SleepView> createState() => _SleepViewState();
}

class _SleepViewState extends State<SleepView> {
  final sleepViewModel = locator<SleepViewModel>();
  final informationViewModel = locator<InformationViewModel>();
  @override
  void initState() {
    sleepViewModel.sleepFellController
        .addListener(sleepViewModel.updateButtonStatusSleep);
    sleepViewModel.sleepWakeupController
        .addListener(sleepViewModel.updateButtonStatusSleep);
    sleepViewModel.sleepNoteController
        .addListener(sleepViewModel.updateButtonStatusSleep);

    if (widget.sleepModel != null) {
      sleepViewModel.sleepFellController.text = widget.sleepModel!.fellSleep;
      sleepViewModel.sleepWakeupController.text = widget.sleepModel!.wakeUp;
      sleepViewModel.sleepNoteController.text = widget.sleepModel!.note;
    } else {
      sleepViewModel.selectedSlep = null;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: CustomElevatedButtonView(
            text: save,
            onTop: () async {
              sleepViewModel.isSleepButtonTapped(context);
            },
            color: darkBlue),
      ),
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBarView(
        appBarTitle: sleep,
        centerTitle: true,
        textColor: darkBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: CustomTextFormField(
                onTap: () {
                  informationViewModel.selectTime(
                      context, sleepViewModel.sleepFellController);
                },
                labelText: fellSleep,
                controller: sleepViewModel.sleepFellController),
          ),
          CustomTextFormField(
              onTap: () {
                informationViewModel.selectTime(
                    context, sleepViewModel.sleepWakeupController);
              },
              labelText: wakeApp,
              controller: sleepViewModel.sleepWakeupController),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: CustomTextFormField(
                hintText: note,
                controller: sleepViewModel.sleepNoteController,
                maxLines: 10),
          ),
        ],
      ),
    );
  }
}
