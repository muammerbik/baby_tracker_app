import 'package:baby_tracker/components/custom_app_bar/custom_app_bar.dart';
import 'package:baby_tracker/components/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/calender/viewmodel/calender_viewmodel.dart';
import 'package:baby_tracker/pages/calender/widgets/custom_all_listView.dart';
import 'package:baby_tracker/pages/calender/widgets/custom_diaper_listView.dart';
import 'package:baby_tracker/pages/calender/widgets/custom_feed_listview.dart';
import 'package:baby_tracker/pages/calender/widgets/custom_sleep_listView.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:baby_tracker/pages/home/view/home_view.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabbarView extends StatefulWidget {
  const TabbarView({Key? key}) : super(key: key);

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarView> with TickerProviderStateMixin {
  late final TabController tabController;
  final calenderViewModel = locator<CalenderViewModel>();
  final feedingViewModel = locator<FeedingViewModel>();
  final diaperViewModel = locator<DiaperViewModel>();
  final sleepViewModel = locator<SleepViewModel>();

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        appBar: CustomAppBarView(
          customLeading: IconButton(
            onPressed: () {
              feedingViewModel.clearControllersFeeding();
              diaperViewModel.clearControllersDiaper();
              sleepViewModel.clearControllersSleep();
              Navigation.ofPop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
          appBarTitle: calender,
          centerTitle: true,
          textColor: btnBlue,
        ),
        body: Column(
          children: [
            Text(
              calenderViewModel.getFormattedDate(
                DateTime.now(),
              ),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: TabBar(
                controller: tabController,
                tabs: <Widget>[
                  Tab(
                    child: Tooltip(
                      message: all,
                      child: Text(
                        all,
                        style: TextStyle(
                            color: grey,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Tab(
                    height: 40.sp,
                    child: Tooltip(
                      message: feeding,
                      child: Image.asset(
                        feedingIcon,
                        color: grey,
                      ),
                    ),
                  ),
                  Tab(
                    height: 40.sp,
                    child: Tooltip(
                      message: diaperChange,
                      child: Image.asset(
                        diaperIcon,
                        color: grey,
                      ),
                    ),
                  ),
                  Tab(
                    child: Tooltip(
                      message: sleep,
                      child: Image.asset(
                        sleepIcon,
                        color: grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  Observer(
                    builder: (context) {
                      calenderViewModel.mergeLists();
                      return const CustomAllListView();
                    },
                  ),
                  Observer(
                    builder: (context) => const CustomFeedListView(),
                  ),
                  Observer(
                    builder: (context) => const CustomDiaperListView(),
                  ),
                  Observer(
                    builder: (context) => const CustomSleepListView(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
