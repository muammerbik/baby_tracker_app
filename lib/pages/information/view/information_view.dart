import 'package:baby_tracker/components/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/components/custom_button/custom_elevated_button.dart';
import 'package:baby_tracker/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:baby_tracker/pages/information/widgets/add_image_widget.dart';
import 'package:baby_tracker/pages/information/widgets/information_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationView extends StatefulWidget {
  const InformationView({Key? key}) : super(key: key);

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  final informationViewModel = locator<InformationViewModel>();

  @override
  void initState() {
    super.initState();
    informationViewModel.loadInformation();
  }

  @override
  Widget build(BuildContext context) {
    final String? localImagePath = informationViewModel.imageFile?.path;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: CustomElevatedButtonView(
          onTop: () async {
            await informationViewModel.isInfoButtonTapped(
              context,
              localImagePath.toString(),
            );
          },
          text: continueButton,
          color: darkPurple,
        ),
      ),
      appBar: CustomAppBarView(
        appBarTitle: "",
        customLeading: GestureDetector(
            onTap: () {
              Navigation.ofPop();
            },
            child: const Icon(Icons.arrow_back)),
      ),
      resizeToAvoidBottomInset: false,
      body: Observer(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const AddImageWidgets(),
            ),
            Observer(
              builder: (context) => Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const InformationRow(),
              ),
            ),
            CustomTextFormField(
              labelText: babyFullName,
              controller: informationViewModel.nameController,
              keyboardType: TextInputType.name,
            ),
            Observer(
              builder: (context) => Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: CustomTextFormField(
                  labelText: birthDate,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    await informationViewModel.selectDate(
                        context, informationViewModel.birthDateController);
                  },
                  controller: informationViewModel.birthDateController,
                ),
              ),
            ),
            CustomTextFormField(
              labelText: timeOfBirth,
              keyboardType: TextInputType.number,
              onTap: () {
                informationViewModel.selectTime(
                    context, informationViewModel.timeOfBirthController);
              },
              controller: informationViewModel.timeOfBirthController,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: CustomTextFormField(
                labelText: dueDate,
                keyboardType: TextInputType.number,
                onTap: () {
                  informationViewModel.selectTime(
                      context, informationViewModel.dueDateController);
                },
                controller: informationViewModel.dueDateController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
