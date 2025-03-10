import 'dart:io';
import 'dart:typed_data';
import 'package:baby_tracker/components/custom_button/custom_alert_dialog.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/core/hive.dart';
import 'package:baby_tracker/data/local_data/information_local_storage.dart';
import 'package:baby_tracker/data/models/information_model.dart';
import 'package:baby_tracker/file/file.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
part 'information_viewmodel.g.dart';

class InformationViewModel = _InformationViewModelBase
    with _$InformationViewModel;

abstract class _InformationViewModelBase with Store {
  final informationDB = locator<InformationLocalStorageHive>();

  _InformationViewModelBase() {
    init();
  }

  @observable
  TextEditingController nameController = TextEditingController();
  @observable
  TextEditingController birthDateController = TextEditingController();
  @observable
  TextEditingController timeOfBirthController = TextEditingController();
  @observable
  TextEditingController dueDateController = TextEditingController();
  @observable
  bool isInformationCompleted = false;
  @observable
  File? imageFile;
  @observable
  ImagePicker picker = ImagePicker();
  @observable
  bool? isGirl;
  @observable
  InformationModel? selectedInformation;

  @action
  Future<void> init() async {
    await loadInformation();
  }

  @action
  void toggleGirlImage() {
    isGirl = true;
  }

  @action
  void toggleSonImage() {
    isGirl = false;
  }

  

  @action
  Future<void> informationCompletedSet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isInformationCompleted", true);
    isInformationCompleted = true;
  }



  @action
  Future<void> informationCompletedGet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isInformationCompleted = pref.getBool("isInformationCompleted") ?? false;
  }



  @action
  Future<void> isInfoButtonTapped(BuildContext context, String pathh) async {
    if (pathh != null &&
        nameController.text.isNotEmpty &&
        birthDateController.text.isNotEmpty &&
        timeOfBirthController.text.isNotEmpty &&
        dueDateController.text.isNotEmpty &&
        imageFile != null) {
      if (selectedInformation != null) {
        await upDate();
      } else {
        await addInformation();
      }

      informationCompletedSet();
      Navigation.push(page: const HomeView());
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const CustomAlertDialog();
        },
      );
    }
  }



  @action
  Future<void> addInformation() async {
    try {
      DateTime parsedBirthDate =
          DateFormat('dd/MM/yyyy').parse(birthDateController.text);
      String imagePath = imageFile?.path ?? "";
      Uint8List imageBytes = await _readFileAsBytes(imagePath);
      final localImagePath =
          await FileHandler().saveFileToPhoneMemory("test.png", imageBytes);

      var model = InformationModel(
        id: const Uuid().v4(),
        img: localImagePath,
        cinsiyet: isGirl ?? false,
        fullName: nameController.text,
        birthDate: DateFormat('yyyy-MM-dd').format(parsedBirthDate),
        timeOfBirth: timeOfBirthController.text,
        dueDate: dueDateController.text,
      );
      await informationBox.clear();
      informationDB.addInformation(informationModel: model);
    } catch (e) {
      print("Hata: $e");
    }
  }



  @action
  Future<void> upDate() async {
    try {
      selectedInformation!.cinsiyet = isGirl!;
      selectedInformation!.fullName = nameController.text;
      selectedInformation!.birthDate = birthDateController.text;
      selectedInformation!.timeOfBirth = timeOfBirthController.text;
      selectedInformation!.dueDate = dueDateController.text;

      if (imageFile != null) {
        Uint8List imageBytes = await _readFileAsBytes(imageFile!.path);
        final localImagePath =
            await FileHandler().saveFileToPhoneMemory("test.png", imageBytes);
        selectedInformation!.img = localImagePath;
      }

      await informationDB.upDateInformation(
          informationModel: selectedInformation!);
    } catch (e) {
      print(e);
    }
  }



  @action
  Future<Uint8List> _readFileAsBytes(String filePath) async {
    try {
      File file = File(filePath);
      Uint8List bytes = await file.readAsBytes();
      return bytes;
    } catch (e) {
      print("Dosya okuma hatası: $e");
      return Uint8List(0);
    }
  }



  @action
  Future<void> loadInformation() async {
    if (informationBox.isNotEmpty) {
      InformationModel lastInformation = informationBox.getAt(0)!;
      selectedInformation = lastInformation;
      nameController.text = lastInformation.fullName;
      imageFile = File(lastInformation.img!);
      isGirl = lastInformation.cinsiyet;
      birthDateController.text = lastInformation.birthDate;
      timeOfBirthController.text = lastInformation.timeOfBirth;
      dueDateController.text = lastInformation.dueDate;
    }
  }



  @action
  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controller.text = picked.format(context);
    }
  }



  @action
  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formattedDate = formatter.format(picked);
      controller.text = formattedDate;
    }
  }



  @action
  imgFromGallery() async {
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then(
      (value) {
        if (value != null) {
          cropImage(File(value.path));
        }
      },
    );
  }



  @action
  imgFromCamera() async {
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50).then(
      (value) {
        if (value != null) {
          cropImage(File(value.path));
        }
      },
    );
  }



  @action
  cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: btnBlue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        ),
      ],
    );

    if (croppedFile != null) {
      imageCache.clear();

      imageFile = File(croppedFile.path);
    }
  }


   String calculateAge(String birthDate) {
    try {
      DateTime birthDateTime = DateFormat('dd/MM/yyyy').parse(birthDate);
      DateTime today = DateTime.now();

      if (birthDateTime.isAfter(today)) {
        return "Geçersiz yaş";
      }

      int days = today.difference(birthDateTime).inDays;

      if (days < 7) {
        return '$days ' +
            ("day" + (days > 1 ? "s" : ""));
      }

      int weeks = (days / 7).floor();

      if (days >= 30) {
        int months =
            (days / 30).floor();
        int remainingWeeks =
            (days - (months * 30)) ~/ 7;

        if (remainingWeeks >= 4) {
          months += 1;
          remainingWeeks -= 4;
        }

        if (months >= 12) {
          int years = months ~/ 12;
          months = months % 12;
          return '$years ' +
              ("year" + (years > 1 ? "s" : "")) +
              ', $months ' +
              ("month" + (months > 1 ? "s" : "")) +
              (remainingWeeks > 0
                  ? ', $remainingWeeks ' +
                      ("week" + (remainingWeeks > 1 ? "s" : ""))
                  : '');
        } else {
          return '$months ' +
              ("month" + (months > 1 ? "s" : "")) +
              (remainingWeeks > 0
                  ? ', $remainingWeeks ' +
                      ("week" + (remainingWeeks > 1 ? "s" : ""))
                  : '');
        }
      }

      return '$weeks ' +
          ("week" + (weeks > 1 ? "s" : "")) +
          (days - (weeks * 7) > 0
              ? ', ${days - (weeks * 7)} ' +
                  ("day" + (days - (weeks * 7) > 1 ? "s" : ""))
              : '');
    } catch (e) {
      return "Tarih ayarlanmadı";
    }
  }
}
