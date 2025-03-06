import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:baby_tracker/pages/information/widgets/action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImageWidgets extends StatefulWidget {
  const AddImageWidgets({Key? key}) : super(key: key);

  @override
  State<AddImageWidgets> createState() => _AddImageWidgetsState();
}

class _AddImageWidgetsState extends State<AddImageWidgets> {
  final informationGetIt = locator<InformationViewModel>();

  @override
  Widget build(BuildContext context) {
  
    return Observer(
      builder: (context) => GestureDetector(
        onTap: () {
          showCustomActionSheet(
            context,
            () {
              informationGetIt.imgFromCamera();
            },
            () {
              informationGetIt.imgFromGallery();
              ;
            },
          );
        },
        child: Stack(
          children: [
            Container(
              width: 150.w,
              height: 150.w,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: purple),
                ),
              ),
              child: informationGetIt.imageFile == null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: Image.asset("assets/images/camera.png"),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(70.r),
                      child: Image.file(
                        informationGetIt.imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: informationGetIt.imageFile == null
                  ? Container(
                      height: 32.w,
                      width: 32.w,
                      decoration: const ShapeDecoration(
                        color: white,
                        shape: OvalBorder(
                          side: BorderSide(width: 1, color: purple),
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/add.png",
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomActionSheet(
    BuildContext context,
    VoidCallback cameraTapped,
    VoidCallback galleryTapped,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ActionSheet(
          cameraTapped: cameraTapped,
          galleryTapped: galleryTapped,
        );
      },
    );
  }
}
