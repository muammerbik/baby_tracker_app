import 'package:baby_tracker/components/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/settings/viewmodel/settings_viewmodel.dart';
import 'package:baby_tracker/pages/settings/widgets/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final settingsViewModel = locator<SettingViewModel>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppBarView(
        appBarTitle: settings,
        centerTitle: true,
        textColor: btnBlue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSettingsButton(
                leadingIcon: settingsImg1,
                title: getPremium,
              ),
              CustomSettingsButton(
                leadingIcon: settingsImg2,
                title: rateUs,
              ),
              CustomSettingsButton(
                leadingIcon: settingsImg3,
                title: termsOfUse,
              ),
              CustomSettingsButton(
                leadingIcon: settingsImg4,
                title: privacyPolicy,
              ),
              CustomSettingsButton(
                leadingIcon: settingsImg5,
                title: contactUs,
              ),
              CustomSettingsButton(
                leadingIcon: settingsImg6,
                title: restorePurchase,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
