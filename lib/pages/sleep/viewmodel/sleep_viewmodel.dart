
import 'package:baby_tracker/components/custom_button/custom_alert_dialog.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/data/local_data/sleep_local_storage.dart';
import 'package:baby_tracker/data/models/sleeep_model.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
part 'sleep_viewmodel.g.dart';

class SleepViewModel = _SleepViewModelBase with _$SleepViewModel;

abstract class _SleepViewModelBase with Store {
  final sleepStorage = locator<SleepLocalStorageHive>();

  _SleepViewModelBase() {
    init();
  }

  @observable
  TextEditingController sleepFellController = TextEditingController();
  @observable
  TextEditingController sleepWakeUpController = TextEditingController();
  @observable
  TextEditingController sleepNoteController = TextEditingController();
  @observable
  List<SleepModel> sleepList = [];
  @observable
  SleepModel? selectedSleep;
  @observable
  bool isButtonEnabledSleep = false;
  @observable
  int? sleepSelectIndex;

  @action
  void updateSelectedIndex(int index) {
    if (sleepSelectIndex == index) {
      sleepSelectIndex = null;
    } else {
      sleepSelectIndex = index;
    }
  }

  @action
  Future<void> init() async {
    await getAll();
  }

  @action
  void updateButtonStatusSleep() {
    isButtonEnabledSleep = isFieldsFilled();
  }

  @action
  bool isFieldsFilled() {
    return sleepFellController.text.isNotEmpty &&
        sleepWakeUpController.text.isNotEmpty &&
        sleepNoteController.text.isNotEmpty;
  }

  @action
  void add(SleepModel sleepModel) {
    sleepList = List.from(sleepList)..insert(0, sleepModel);
  }

  @action
  void clearControllersSleep() {
    sleepFellController.clear();
    sleepWakeUpController.clear();
    sleepNoteController.clear();
  }

  @action
  Future<void> isSleepButtonTapped(BuildContext context) async {
    if (isButtonEnabledSleep) {
      if (selectedSleep == null) {
        await addSleep();
      } else {
        upDate(selectedSleep!.id);
      }

      Navigation.push(page: const HomeView());
      clearControllersSleep();
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
  SleepModel getItemSleep(String id) {
    return sleepList.firstWhere((feed) => feed.id == id);
  }


  @action
  Future<void> addSleep() async {
    try {
      var sleepModel = SleepModel(
          id: const Uuid().v1(),
          fellSleep: sleepFellController.text,
          wakeUp: sleepWakeUpController.text,
          note: sleepNoteController.text);
      await sleepStorage.addSleep(sleepModel: sleepModel);
      add(sleepModel);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }


  @action
  Future<void> getAll() async {
    sleepList.clear();
    var data = await sleepStorage.getAllSSleep();
    sleepList.addAll(data);
  }


  @action
  Future<void> delete(String id) async {
    try {
      SleepModel sleepToDelete = sleepList.firstWhere((feed) => feed.id == id);
      await sleepStorage.deleteSleep(sleepModel: sleepToDelete);
      sleepList.remove(sleepToDelete);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }


  @action
  Future<void> upDate(String id) async {
    try {
      SleepModel sleepToUpdate = sleepList.firstWhere((feed) => feed.id == id);
      sleepToUpdate.fellSleep = sleepFellController.text;
      sleepToUpdate.wakeUp = sleepWakeUpController.text;
      sleepToUpdate.note = sleepNoteController.text;
      await sleepStorage.upDateSleep(sleepModel: sleepToUpdate);
      sleepList = List.from(sleepList);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }
}
