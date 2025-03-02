import 'package:baby_tracker/companents/custom_snack_bar/custom_snack_bar.dart';
import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/pages/home/view/home_view.dart';
import 'package:baby_tracker/pages/information/view/information_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'inapp_view_model.g.dart';

class InAppViewModel = _InAppViewModelBase with _$InAppViewModel;

abstract class _InAppViewModelBase with Store {
  @observable
  int selectedButtonIndex = -1;

  @observable
  bool isInAppCompleted = false;

  @action
  void selectPlan(int index) {
    selectedButtonIndex = index;
  }

  @action
  Future<void> inAppButtonTapped(BuildContext context) async {
    if (selectedButtonIndex == -1) {
      CustomSnackBar.show(
        context: context,
        message: snackBarText,
        containerColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    await inAppCompletedSet();
    await inAppCompletedGet();

    if (isInAppCompleted) {
      Navigation.pushAndRemoveAll(page: const InformationView());
    }
  }

  @action
  Future<void> inAppCompletedSet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isInAppCompleted", true);
    isInAppCompleted = true;
  }

  @action
  Future<void> inAppCompletedGet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isInAppCompleted = pref.getBool("isInAppCompleted") ?? false;
  }
}
