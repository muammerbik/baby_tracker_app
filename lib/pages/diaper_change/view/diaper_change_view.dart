// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:baby_tracker/components/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/components/custom_button/custom_elevated_button.dart';
import 'package:baby_tracker/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:baby_tracker/data/models/diaper_change_model.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:baby_tracker/pages/diaper_change/widgets/diaper_change_column.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiaperChangeView extends StatefulWidget {
  final DiaperChangeModel? diaperChangeModel;
  const DiaperChangeView({
    Key? key,
    this.diaperChangeModel,
  }) : super(key: key);

  @override
  State<DiaperChangeView> createState() => _DiaperChangeViewState();
}

class _DiaperChangeViewState extends State<DiaperChangeView> {
  final diaperViewModel = locator<DiaperViewModel>();
  final informationViewModel = locator<InformationViewModel>();

  @override
  void initState() {
    diaperViewModel.diaperTimeController
        .addListener(diaperViewModel.updateButtonStatus);
    diaperViewModel.diaperNoteController
        .addListener(diaperViewModel.updateButtonStatus);

    if (widget.diaperChangeModel != null) {
      diaperViewModel.diaperTimeController.text =
          widget.diaperChangeModel!.time;
      diaperViewModel.selectedStatus = DiaperStatus
          .values[int.parse(widget.diaperChangeModel!.diaperStatus)];
      diaperViewModel.diaperNoteController.text =
          widget.diaperChangeModel!.note;
      diaperViewModel.selectedDiaper = widget.diaperChangeModel;
    } else {
      diaperViewModel.selectedDiaper = null;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        child: CustomElevatedButtonView(
            text: save,
            onTop: () async {
              diaperViewModel.isDiaperChangeButtonTapped(context);
            },
            color: lightblue),
      ),
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBarView(
        appBarTitle: diaperChange,
        centerTitle: true,
        textColor: lightblue,
      ),
      body: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextFormField(
                labelText: time,
                controller: diaperViewModel.diaperTimeController,
                onTap: () {
                  informationViewModel.selectTime(
                      context, diaperViewModel.diaperTimeController);
                },
                keyboardType: TextInputType.number),
            const DiaperChangeColumn(),
            CustomTextFormField(
              hintText: note,
              controller: diaperViewModel.diaperNoteController,
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
