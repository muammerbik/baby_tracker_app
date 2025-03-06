import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationRow extends StatefulWidget {
  const InformationRow({Key? key}) : super(key: key);

  @override
  State<InformationRow> createState() => _InformationRowState();
}

class _InformationRowState extends State<InformationRow> {
  final informationViewModel = locator<InformationViewModel>();
  @override
  Widget build(BuildContext context) {
  
    return Observer(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              informationViewModel.toggleGirlImage();
            },
            child: informationViewModel.isGirl != null &&
                    informationViewModel.isGirl!
                ? Image.asset(
                    "assets/images/bbbx.png",
                    height: 32.h,
                    width: 32.w,
                  )
                : Image.asset(
                    "assets/images/xx.png",
                    height: 32.h,
                    width: 32.w,
                  ),
          ),
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () {
              informationViewModel.toggleSonImage();
            },
            child: informationViewModel.isGirl != null &&
                    !informationViewModel.isGirl!
                ? Image.asset(
                    "assets/images/aaay.png",
                    height: 32.h,
                    width: 32.w,
                  )
                : Image.asset(
                    "assets/images/yy.png",
                    height: 32.h,
                    width: 32.w,
                  ),
          ),
        ],
      ),
    );
  }
}
