import 'package:baby_tracker/components/custom_button/custom_elevated_button.dart';
import 'package:baby_tracker/components/custom_text/text_widget.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/inapp/viewmodel/inapp_view_model.dart';
import 'package:baby_tracker/pages/inapp/widgets/inapp_buttons.dart';
import 'package:baby_tracker/pages/information/view/information_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InAppView extends StatefulWidget {
  const InAppView({Key? key}) : super(key: key);

  @override
  State<InAppView> createState() => _InAppViewState();
}

class _InAppViewState extends State<InAppView> {
  final inAppViewModel = locator<InAppViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Observer(
        builder: (context) => Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: CustomElevatedButtonView(
              text: btnStart,
              onTop: () {
                inAppViewModel.inAppButtonTapped(context);
              },
              color: btnBlue),
        ),
      ),
      body: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32.h, right: 4.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigation.push(page: const InformationView());
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
            TextWidgets(text: getPremium, size: 27.sp, color: btnBlue),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Image.asset(
                inappImageBaby,
                height: 136.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: TextWidgets(
                text: premiumTextMessage,
                size: 20.sp,
                color: Colors.black,
              ),
            ),
            CustomInAppButtonWidget(
              premiumTime: weekly,
              premiumMoney: weekly$,
              isSelected: inAppViewModel.selectedButtonIndex == 0,
              onTap: () => inAppViewModel.selectPlan(0),
            ),
            CustomInAppButtonWidget(
              premiumTime: monthly,
              premiumMoney: monthly$,
              isSelected: inAppViewModel.selectedButtonIndex == 1,
              onTap: () => inAppViewModel.selectPlan(1),
            ),
            CustomInAppButtonWidget(
              premiumTime: annual,
              premiumMoney: annual$,
              isSelected: inAppViewModel.selectedButtonIndex == 2,
              onTap: () => inAppViewModel.selectPlan(2),
            ),
          ],
        ),
      ),
    );
  }
}
