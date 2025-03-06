import 'package:baby_tracker/components/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/components/custom_button/custom_elevated_button.dart';
import 'package:baby_tracker/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:baby_tracker/data/models/feeding_model.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedingView extends StatefulWidget {
  final FeedingModel? feedingModel;
  const FeedingView({
    Key? key,
    this.feedingModel,
  }) : super(key: key);

  @override
  State<FeedingView> createState() => _FeedingViewState();
}

class _FeedingViewState extends State<FeedingView> {
  final feedingViewModel = locator<FeedingViewModel>();
  final informationViewModel = locator<InformationViewModel>();
  @override
  void initState() {
    feedingViewModel.timeController
        .addListener(feedingViewModel.updateButtonStatus);
    feedingViewModel.mlController
        .addListener(feedingViewModel.updateButtonStatus);
    feedingViewModel.noteController
        .addListener(feedingViewModel.updateButtonStatus);

    if (widget.feedingModel != null) {
      feedingViewModel.noteController.text = widget.feedingModel!.note;
      feedingViewModel.timeController.text = widget.feedingModel!.time;
      feedingViewModel.mlController.text =
          widget.feedingModel!.amount.toString();
      feedingViewModel.selectedFeed = widget.feedingModel;
    } else {
      feedingViewModel.selectedFeed = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: CustomElevatedButtonView(
            text: save,
            onTop: () async {
              feedingViewModel.isFeedingButtonTapped(context);
            },
            color: darkPurple),
      ),
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBarView(
        appBarTitle: feeding,
        textColor: darkBlue,
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: CustomTextFormField(
                labelText: time,
                controller: feedingViewModel.timeController,
                keyboardType: TextInputType.name,
                onTap: () {
                  informationViewModel.selectTime(
                    context,
                    feedingViewModel.timeController,
                  );
                },
              ),
            ),
            CustomTextFormField(
              labelText: amount,
              controller: feedingViewModel.mlController,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: CustomTextFormField(
                hintText: note,
                controller: feedingViewModel.noteController,
                keyboardType: TextInputType.name,
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
