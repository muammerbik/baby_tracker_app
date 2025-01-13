
import 'package:baby_tracker/companents/custom_text/text_widget.dart';
import 'package:baby_tracker/companents/navigation_helper/navigation_helper.dart';
import 'package:baby_tracker/constants/app_strings.dart';
import 'package:baby_tracker/constants/device_config.dart';
import 'package:baby_tracker/get_it/get_it.dart';
import 'package:baby_tracker/pages/calender/viewmodel/calender_viewmodel.dart';
import 'package:baby_tracker/pages/diaper_change/view/diaper_change_view.dart';
import 'package:baby_tracker/pages/diaper_change/viewmodel/diaper_viewmodel.dart';
import 'package:baby_tracker/pages/feeding/view/feeding_view.dart';
import 'package:baby_tracker/pages/feeding/viewmodel/feeding_viewmodel.dart';
import 'package:baby_tracker/pages/sleep/view/sleep_view.dart';
import 'package:baby_tracker/pages/sleep/viewmodel/sleep_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomAllListView extends StatefulWidget {
  const CustomAllListView({super.key});

  @override
  State<CustomAllListView> createState() => _CustomAllListViewState();
}

class _CustomAllListViewState extends State<CustomAllListView> {
  final calenderViewmodel = locator<CalenderViewMoel>();
  final feedingViewmodel = locator<FeedingViewModel>();
  final sleepViewmodel = locator<SleepViewModel>();
  final diaperViewmodel = locator.get<DiaperViewModel>();

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);
    return Observer(
      builder: (context) => Center(
        child: calenderViewmodel.mergedList.isNotEmpty
            ? ListView.builder(
                itemCount: calenderViewmodel.mergedList.length,
                itemBuilder: (context, index) {
                  final item = calenderViewmodel.mergedList[index];
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: const Row(children: [
                      Icon(
                        Icons.delete,
                        color: red,
                        size: 30,
                      ),
                      TextWidgets(
                        text: delete,
                        size: 20,
                        color: black,
                      )
                    ]),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      if (item.type == "feeding") {
                        feedingViewmodel.delete(item.id);
                      } else if (item.type == "diaper") {
                        diaperViewmodel.delete(item.id);
                      } else {
                        sleepViewmodel.delete(item.id);
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (item.type == "feeding") {
                          Navigation.push(
                            page: FeedingView(
                                feedingModel:
                                    feedingViewmodel.getItem(item.id)),
                          );

                          feedingViewmodel.selectedFeed =
                              feedingViewmodel.feedList[index];
                        } else if (item.type == "diaper") {
                          Navigation.push(
                            page: DiaperChangeView(
                                diaperChangeModel:
                                    diaperViewmodel.getItemDiaper(item.id)),
                          );

                          diaperViewmodel.selectedDiaper =
                              diaperViewmodel.diaperList[index];
                        } else {
                          Navigation.push(
                            page: SleepView(
                              sleepModel: sleepViewmodel.getItemSlep(item.id),
                            ),
                          );

                          sleepViewmodel.selectedSlep =
                              sleepViewmodel.sleepList[index];
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: DeviceConfig.screenHeight! * 0.0109,
                            horizontal: DeviceConfig.screenHeight! * 0.0200),
                        child: Container(
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: darkWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        DeviceConfig.screenWidth! * 0.0373,
                                    vertical:
                                        DeviceConfig.screenHeight! * 0.0107),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          item.iconPath,
                                          height: DeviceConfig.screenHeight! *
                                              0.0480,
                                          color: darkBlue,
                                        ),
                                        const SizedBox(width: 5),
                                        TextWidgets(
                                          text: item.category,
                                          size: 18,
                                          color: darkBlue,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            DeviceConfig.screenWidth! * 0.044,
                                      ),
                                      child: TextWidgets(
                                        text: item.date,
                                        size: 16,
                                        color: black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                title: Row(
                                  children: [
                                    Image.asset(
                                      calenderImg,
                                      color: orange.shade800,
                                      height:
                                          DeviceConfig.screenHeight! * 0.0451,
                                    ),
                                    Text(
                                      calenderViewmodel.capitalizeWithSuffix(
                                          item.type, notee),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        calenderViewmodel
                                            .updateSelectedIndex(index);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    calenderViewmodel.allSelectedIndex == index
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                ),
                              ),
                              if (calenderViewmodel.allSelectedIndex == index)
                                Observer(
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            DeviceConfig.screenWidth! * 0.0373,
                                        vertical: DeviceConfig.screenHeight! *
                                            0.0107),
                                    child: Text(
                                      item.note,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: TextWidgets(
                  text: diaperIsempty,
                  size: 18,
                  color: black,
                ),
              ),
      ),
    );
  }
}
