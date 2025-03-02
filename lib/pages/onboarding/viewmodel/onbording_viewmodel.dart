import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/pages/inapp/view/inapp_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'onbording_viewmodel.g.dart';

class OnboardingViewModel = _OnboardingViewModelBase with _$OnboardingViewModel;

abstract class _OnboardingViewModelBase with Store {
  @observable
  bool isOnboardingCompleted = false;

  @observable
  PageController pageController = PageController();

  @observable
  int currentIndex = 0;

  @observable
  bool notGoBack = false;

  
  @action
  void onPageChanged(int value) {
    currentIndex = value;
  }

  @action
  Future<void> onboardingCompletedSet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isOnboardingCompleted", true);
  }

  @action
  Future<void> onboardingCompletedGet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isOnboardingCompleted = pref.getBool("isOnboardingCompleted") ?? false;
  }

  @action
  void continueButtonTapped() {
    if (currentIndex == OnboardingList.length - 1) {
      onboardingCompletedSet();
      Navigation.push(page: const InAppView());
    }
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }


  @observable
  List<OnboardingModel> OnboardingList = [
    OnboardingModel(
      img: onboardingImg1,
      title: onboardingTitle1,
      subTitle: onboardingSubTitle1,
    ),
    OnboardingModel(
        img: onboardingImg2,
        title: onboardingTitle2,
        subTitle: onboardingSubTitle2),
    OnboardingModel(
        img: onboardingImg3,
        title: onboardingTitle3,
        subTitle: onboardingSubTiitle3),
  ];
}

class OnboardingModel {
  final String img;
  final String title;
  final String subTitle;
  OnboardingModel({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}
