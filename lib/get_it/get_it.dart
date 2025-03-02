import 'package:baby_tracker/data/local_data/diaper_local_storage.dart';
import 'package:baby_tracker/data/local_data/feeding_local_storage.dart';
import 'package:baby_tracker/data/local_data/information_local_storage.dart';
import 'package:baby_tracker/data/local_data/sleep_local_storage.dart';
import 'package:baby_tracker/pages/calender/viewmodel/calender_viewmodel.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:baby_tracker/pages/home/viewmodel/home_viewmodel.dart';
import 'package:baby_tracker/pages/inapp/viewmodel/inapp_view_model.dart';
import 'package:baby_tracker/pages/information/viewmodel/information_viewmodel.dart';
import 'package:baby_tracker/pages/onboarding/viewmodel/onbording_viewmodel.dart';
import 'package:baby_tracker/pages/settings/viewmodel/settings_viewmodel.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void setupGetIt() {
  locator.registerLazySingleton<DiaperLocalStorageHive>(() => DiaperStorage());
  locator.registerLazySingleton<FeedingLocalStorageHive>(() => FeedingStorage());
  locator.registerLazySingleton<SleepLocalStorageHive>(() => SleepStorage());
  locator.registerLazySingleton<InformationLocalStorageHive>(() => InformationStorage());
  locator.registerSingleton<OnboardingViewModel>(OnboardingViewModel());
  locator.registerSingleton<InAppViewModel>(InAppViewModel());
  locator.registerSingleton<InformationViewModel>(InformationViewModel());
  locator.registerSingleton<FeedingViewModel>(FeedingViewModel());
  locator.registerSingleton<SleepViewModel>(SleepViewModel());
  locator.registerSingleton<DiaperViewModel>(DiaperViewModel());
  locator.registerSingleton<SettingViewModel>(SettingViewModel());
  locator.registerSingleton<CalenderViewModel>(CalenderViewModel());
  locator.registerSingleton<HomeViewModel>(HomeViewModel());


}
