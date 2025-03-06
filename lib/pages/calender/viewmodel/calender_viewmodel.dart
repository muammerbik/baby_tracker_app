import 'package:baby_tracker/data/models/feed_item_model.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'calender_viewmodel.g.dart';

class CalenderViewModel = _CalenderViewModelBase with _$CalenderViewModel;

abstract class _CalenderViewModelBase with Store {
  final feedingViewModel = locator<FeedingViewModel>();
  final diaperViewModel = locator<DiaperViewModel>();
  final sleepViewModel = locator<SleepViewModel>();

  @observable
  List<FeedItem> mergedList = [];

  @observable
  int? allSelectedIndex;

  @action
  void updateSelectedIndex(int index) {
    if (allSelectedIndex == index) {
      allSelectedIndex = null;
    } else {
      allSelectedIndex = index;
    }
  }

  @action
  String capitalizeWithSuffix(String text, String suffix) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1) + suffix;
  }

  @action
  String getFormattedDate(DateTime date) {
    final dayFormat = DateFormat('E');
    final dateFormat = DateFormat('d MMMM y');

    final day = dayFormat.format(date);
    final formattedDate = dateFormat.format(date);

    return '$day, $formattedDate';
  }

  @action
  void mergeLists() {
    mergedList.clear();
    mergedList.insertAll(
        0,
        feedingViewModel.feedList.map((feeding) => FeedItem(
              id: feeding.id,
              type: "feeding",
              date: feeding.time,
              iconPath: "assets/images/bottle.png",
              category: "Feeding",
              time: feeding.time,
              note: feeding.note,
            )));
    mergedList.insertAll(
        0,
        diaperViewModel.diaperList.map((diaper) => FeedItem(
              id: diaper.id,
              type: "diaper",
              date: diaper.time,
              iconPath: "assets/images/diaper1.png",
              category: "Diaper Change",
              time: diaper.time,
              note: diaper.note,
            )));
    mergedList.insertAll(
        0,
        sleepViewModel.sleepList.map((sleep) => FeedItem(
              id: sleep.id,
              type: "sleep",
              date: sleep.wakeUp,
              iconPath: "assets/images/sleep.png",
              category: "Sleep",
              time: sleep.wakeUp,
              note: sleep.note,
            )));

    mergedList.sort((a, b) => b.date.compareTo(a.date));
  }
}
