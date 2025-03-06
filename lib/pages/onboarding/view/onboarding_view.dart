import 'package:baby_tracker/components/custom_button/custom_elevated_button.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/onboarding/viewmodel/onbording_viewmodel.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final onboardingViewModel = locator<OnboardingViewModel>();

  @override
  void initState() {
    onboardingViewModel.pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    onboardingViewModel.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: CustomElevatedButtonView(
          onTop: () {
            onboardingViewModel.continueButtonTapped();
          },
          text: btnNext,
          color: btnBlue,
        ),
      ),
      body: Observer(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: onboardingViewModel.pageController,
                  onPageChanged: onboardingViewModel.onPageChanged,
                  physics: onboardingViewModel.notGoBack
                      ? const PageScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemCount: onboardingViewModel.onboardingList.length,
                  itemBuilder: (context, index) {
                    final onboardingItem =
                        onboardingViewModel.onboardingList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            onboardingItem.img,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Text(
                              onboardingItem.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            onboardingItem.subTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: DotsIndicator(
                  dotsCount: onboardingViewModel.onboardingList.length,
                  position: onboardingViewModel.currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: grey,
                    activeColor: btnBlue,
                    size: const Size.square(10.0),
                    activeSize: const Size(24.0, 10.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
