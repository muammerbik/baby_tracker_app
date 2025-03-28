
import 'package:baby_tracker/components/custom_button/custom_alert_dialog.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/data/local_data/diaper_local_storage.dart';
import 'package:baby_tracker/data/models/diaper_change_model.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
part 'diaper_viewmodel.g.dart';

// ignore: constant_identifier_names
enum DiaperStatus { Wet, Dirty, Mixed, Dry }

class DiaperViewModel = _DiaperViewModelBase with _$DiaperViewModel;

abstract class _DiaperViewModelBase with Store {
  final diaperStorage = locator<DiaperLocalStorageHive>();

  _DiaperViewModelBase() {
    reaction(
      (_) => selectedStatus,
      (DiaperStatus? status) {
        updateButtonStatus();
      },
    );
    init();
  }

  @observable
  DiaperStatus? selectedStatus;
  @observable
  DiaperChangeModel? selectedDiaper;
  @observable
  bool isButtonEnabledDiaper = false;
  @observable
  TextEditingController diaperTimeController = TextEditingController();
  @observable
  TextEditingController diaperNoteController = TextEditingController();
  @observable
  List<DiaperChangeModel> diaperList = [];

  @observable
  int? diaperSelectedIndex;

  @action
  void updateSelectedIndex(int index) {
    if (diaperSelectedIndex == index) {
      diaperSelectedIndex = null;
    } else {
      diaperSelectedIndex = index;
    }
  }

  @action
  DiaperChangeModel getItemDiaper(String id) {
    return diaperList.firstWhere((feed) => feed.id == id);
  }

  @action
  Future<void> init() async {
    await getAll();
  }

  @action
  void add(DiaperChangeModel diaperChange) {
    diaperList = List.from(diaperList)..insert(0, diaperChange);
  }

  @action
  void updateButtonStatus() {
    isButtonEnabledDiaper = statusButtonTapped();
  }

  @action
  void clearControllersDiaper() {
    diaperTimeController.clear();
    selectedStatus = null;
    diaperNoteController.clear();
  }

  @action
  bool statusButtonTapped() {
    return diaperTimeController.text.isNotEmpty &&
        diaperNoteController.text.isNotEmpty &&
        selectedStatus!.index.toString().isNotEmpty;
  }

  @action
  void setSelectedStatus(DiaperStatus? status) {
    selectedStatus = status;
  }

  @action
  Future<void> isDiaperChangeButtonTapped(BuildContext context) async {
    if (isButtonEnabledDiaper) {
      if (selectedDiaper == null) {
        await addDiaperChange();
      } else {
        await upDate(selectedDiaper!.id);
      }
      Navigation.push(page: const HomeView());
      clearControllersDiaper();
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
  Future<void> addDiaperChange() async {
    try {
      var diaperModel = DiaperChangeModel(
          id: const Uuid().v1(),
          time: diaperTimeController.text,
          diaperStatus: selectedStatus!.index.toString(),
          note: diaperNoteController.text);

      await diaperStorage.addDiaper(diaperChangeModel: diaperModel);
      add(diaperModel);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @action
  Future<void> getAll() async {
    diaperList.clear();
    var data = await diaperStorage.getAllDiaper();
    diaperList.addAll(data);
  }

  @action
  Future<void> delete(String id) async {
    try {
      DiaperChangeModel diaperToDelete =
          diaperList.firstWhere((feed) => feed.id == id);
      await diaperStorage.deleteDiaper(diaperChangeModel: diaperToDelete);
      diaperList.remove(diaperToDelete);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  @action
  Future<void> upDate(String id) async {
    try {
      DiaperChangeModel diaperToUpdate =
          diaperList.firstWhere((feed) => feed.id == id);
      diaperToUpdate.time = diaperTimeController.text;
      diaperToUpdate.diaperStatus = selectedStatus!.index.toString();
      diaperToUpdate.note = diaperNoteController.text;
      await diaperStorage.upDateDiaper(diaperChangeModel: diaperToUpdate);
      diaperList = List.from(diaperList);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
