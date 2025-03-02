import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/home/view/home_view.dart';
import 'package:baby_tracker/pages/inapp/view/inapp_view.dart';
import 'package:baby_tracker/pages/inapp/viewmodel/inapp_view_model.dart';
import 'package:baby_tracker/pages/information/view/information_view.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:baby_tracker/pages/onboarding/view/onboarding_view.dart';
import 'package:baby_tracker/pages/onboarding/viewmodel/onbording_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final onboardingViewModel = locator<OnboardingViewModel>();
  final inAppViewModel = locator<InAppViewModel>();
  final informationViewModel = locator<InformationViewModel>();

  @override
  initState() {
    onboardingViewModel.onboardingCompletedGet();
    inAppViewModel.inAppCompletedGet();
    informationViewModel.informationCompletedGet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (onboardingViewModel.isOnboardingCompleted == true &&
            inAppViewModel.isInAppCompleted == true &&
            informationViewModel.isInformationCompleted == true) {
          return const HomeView();
        } else if (onboardingViewModel.isOnboardingCompleted == true &&
            inAppViewModel.isInAppCompleted == true) {
          return const InformationView();
        } else if (onboardingViewModel.isOnboardingCompleted == true) {
          return const InAppView();
        } else {
          return const OnboardingView();
        }
      },
    );
  }
}
