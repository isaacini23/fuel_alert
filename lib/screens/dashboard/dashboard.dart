import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/app/app-state-controller.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/controller/rewards/rewards-state-controller.dart';
import 'package:fuel_alert/core/functions/location.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});


  final AppStateController appStateController = Get.put(AppStateController());
  final ProfileStateController profileStateController =
      Get.put(ProfileStateController());
  final HomeStateController _homeStateController =
      Get.put(HomeStateController());
  final RewardStateController _rewardStateController =
      Get.put(RewardStateController());


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      Timer.periodic(const Duration(seconds: 5), (timer) async {
          await getLocation();
      });
      profileStateController.getProfile(context);
      _homeStateController.getAllStations();
      _homeStateController.getFavouriteStations();
      _homeStateController.getRecentSearchList();
      _homeStateController.getPriceReference();
      _homeStateController.loadLocationPreference();
      _homeStateController.getAllNotifications();
      _rewardStateController.getPointsConfig();
      _rewardStateController.getRewardLeadershipBoard();
      _homeStateController.loadLocationPreference();
    });

    return GetBuilder<AppStateController>(builder: (controller) {
      return Scaffold(
        body: controller.dashboardViews[controller.viewIndex],
        bottomNavigationBar: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).bottomAppBarTheme.color,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -4),
                    blurRadius: 16.96,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.10))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    controller.updateViewIndex(0);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/Home icon.svg",
                        color: Color((controller.viewIndex == 0)
                            ? 0xff009933
                            : 0xff9C9C9C),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: Color((controller.viewIndex == 0)
                                ? 0xff009933
                                : 0xff9C9C9C),
                            fontSize: 13.35,
                            fontFamily: "PoppinsMeds"),
                      )
                    ],
                  )),
              InkWell(
                  onTap: () {
                    controller.updateViewIndex(1);
                    _homeStateController.getFavouriteStations();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/Fav icon.svg",
                        color: Color((controller.viewIndex == 1)
                            ? 0xff009933
                            : 0xff9C9C9C),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Favourite",
                        style: TextStyle(
                            color: Color((controller.viewIndex == 1)
                                ? 0xff009933
                                : 0xff9C9C9C),
                            fontSize: 13.35,
                            fontFamily: "PoppinsMeds"),
                      )
                    ],
                  )),
              InkWell(
                  onTap: () {
                    controller.updateViewIndex(2);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/Reward icon.svg",
                        color: Color((controller.viewIndex == 2)
                            ? 0xff009933
                            : 0xff9C9C9C),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rewards",
                        style: TextStyle(
                            color: Color((controller.viewIndex == 2)
                                ? 0xff009933
                                : 0xff9C9C9C),
                            fontSize: 13.35,
                            fontFamily: "PoppinsMeds"),
                      )
                    ],
                  )),
              InkWell(
                  onTap: () {
                    controller.updateViewIndex(3);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/Setting.svg",
                        color: Color((controller.viewIndex == 3)
                            ? 0xff009933
                            : 0xff9C9C9C),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                            color: Color((controller.viewIndex == 3)
                                ? 0xff009933
                                : 0xff9C9C9C),
                            fontSize: 13.35,
                            fontFamily: "PoppinsMeds"),
                      )
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
