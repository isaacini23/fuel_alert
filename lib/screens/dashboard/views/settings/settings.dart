import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/app/app-state-controller.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/functions/url-launcher.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/widget/pop-ups/logout-pop-up.dart';
import 'package:fuel_alert/widget/pop-ups/warning-sheet.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AppStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          automaticallyImplyLeading: false,
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 24,
                color: Theme.of(context).textTheme.titleLarge?.color),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Account",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: [
                            _tile(
                                context: context,
                                title: "Profile",
                                action: () {
                                  Get.toNamed(profileView);
                                },
                                image: "profile"),
                            const SizedBox(
                              height: 10,
                            ),
                            _tile(
                                context: context,
                                title: "My points",
                                action: () {
                                  Get.toNamed(myPointsView);
                                },
                                image: "points"),
                            const SizedBox(
                              height: 10,
                            ),
                            // _tile(
                            //     title: "My rewards",
                            //     action: () {
                            //       Get.toNamed(myRewardsView);
                            //     },
                            //     image: "rewards"),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            _tile(
                                context: context,
                                title: "My reviews",
                                action: () {
                                  Get.toNamed(myReviewView);
                                },
                                image: "reviews"),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<HomeStateController>(
                              builder: (hController) {
                                return _tile(
                                    context: context,
                                    title: "My favourite stations",
                                    action: () {
                                      hController.getFavouriteStations();
                                      controller.updateViewIndex(1);
                                    },
                                    image: "favs");
                              }
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _tile(
                                context: context,
                                title: "Change Location",
                                action: () {
                                  Get.toNamed(changeLocationView);
                                },
                                image: "location"),
                            const SizedBox(
                              height: 10,
                            ),
                            _tile(
                                context: context,
                                title: "Change password",
                                action: () {
                                  Get.toNamed(changePasswordView);
                                },
                                image: "password"),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<ProfileStateController>(
                              builder: (profileController) {
                                return ListTile(
                                  onTap: () {
                                    WarningSheet().show(context,
                                        title: "Delete Account", action: () {
                                      profileController.deleteAccount();
                                    },
                                        subtitle:
                                            "This action is irreversible. Your account will be permanently deleted. Are you sure you want to proceed?");
                                  },
                                  horizontalTitleGap: 5,
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                      SvgPicture.asset("assets/images/trash.svg"),
                                  title: const Text(
                                    "Delete account",
                                    style: TextStyle(
                                        color: Color(0xffDE4841), fontSize: 20),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.color,
                                    size: 20,
                                  ),
                                );
                              }
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Notification",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: [
                            _tile(
                                context: context,
                                title: "Notifications",
                                action: () {
                                  Get.toNamed(notificationView);
                                },
                                image: "notification"),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<HomeStateController>(
                                builder: (homeController) {
                              return _tile2(
                                  context: context,
                                  value: homeController.pushNotificationActive,
                                  onChanged: (value) {
                                    homeController.togglePushNotification();
                                  },
                                  image: "push-notification",
                                  title: "Push Notifications");
                            })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: [
                            GetBuilder<HomeStateController>(
                                builder: (homeController) {
                              return _tile2(
                                  context: context,
                                  value: homeController.isLocationEnabled,
                                  onChanged: (value) {
                                    homeController.onToggleLocation(value);
                                  },
                                  image: "location",
                                  title: homeController.isLocationEnabled ?
                                  "Disable Location Service":
                                  "Enable Location Service");
                            })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Theme",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            children: [
                              Obx(() => _tile2(
                                    context: context,
                                    title: "Dark mode",
                                    image: "dark-mode",
                                    value:
                                        themeController.selectedTheme.value ==
                                            ThemeMode.dark,
                                    onChanged: (value) {
                                      if (value) {
                                        themeController.toggleDarkMode(true);
                                      } else {
                                        themeController.toggleDarkMode(false);
                                      }
                                    },
                                  )),
                              const SizedBox(height: 10),
                              Obx(() => _tile2(
                                    context: context,
                                    title: "Use system default",
                                    image: "system-default",
                                    value:
                                        themeController.selectedTheme.value ==
                                            ThemeMode.system,
                                    onChanged: (value) {
                                      if (value) {
                                        themeController.toggleSystemMode(true);
                                      } else {
                                        themeController.toggleSystemMode(false);
                                      }
                                    },
                                  )),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Support Center",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: [
                            _tile(
                                context: context,
                                title: "Contact us",
                                image: "contactus",
                                action: () {
                                  launchUrls(
                                      "https://docs.google.com/forms/d/e/1FAIpQLSdrTpOcGkn3cIZodQ7eRRH9RdgpR_jQWVwjd4kVAFUrM8XIrg/viewform");
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            _tile(
                                context: context,
                                title: "About us",
                                image: "aboutus",
                                action: () {
                                  launchUrls(
                                      "https://www.fuelalertng.com/about");
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            _tile(
                                context: context,
                                title: "Terms of service",
                                image: "terms",
                                action: () {
                                  launchUrls(
                                      "https://www.fuelalertng.com/terms");
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            _tile(
                                context: context,
                                title: "Privacy policy",
                                image: "privacy",
                                action: () {
                                  launchUrls(
                                      "https://www.fuelalertng.com/privacy");
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 53,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            LogoutSheet().show(context,
                                title: "Logout",
                              subtitle:
                                    "Are you sure you want to proceed to logout ?");
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xff009933),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "PoppinsMeds"),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 60,
                  color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "Version: 1.0 All rights reserved ©FuelAlert ${DateTime.now().year}",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleMedium?.color,
                          fontSize: 10.5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    );
  }

  ListTile _tile({image, title, action, required context}) {
    return ListTile(
      onTap: action,
      horizontalTitleGap: 5,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset("assets/images/$image.svg"),
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 20),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).textTheme.titleMedium?.color,
        size: 20,
      ),
    );
  }

  ListTile _tile2(
      {required String image,
      required String title,
      required bool value,
      required context,
      required Function(bool) onChanged}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      leading: SvgPicture.asset("assets/images/$image.svg"),
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 20),
      ),
      trailing: Switch.adaptive(value: value, onChanged: onChanged),
    );
  }
}
