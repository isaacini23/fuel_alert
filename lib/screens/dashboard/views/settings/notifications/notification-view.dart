import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/core/functions/date-formatters.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final HomeStateController _homeStateController =
      Get.find<HomeStateController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      _homeStateController.getAllNotifications();
    });

    return GetBuilder<HomeStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
              )),
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          title: Text(
            "Notifications",
            style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 24,
                color: Theme.of(context).textTheme.titleLarge?.color),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [const PopupMenuItem(child: Text("Clear"))];
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).textTheme.headlineMedium?.color,
              ),
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          child: (controller.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: controller.groupNotificationsByDate(
                                (controller.userNotificationList)
                                    .cast<Map<String, dynamic>>())
                            .entries
                            .map((entry) {
                          String date = entry.key;
                          List<Map<String, dynamic>> notificationsForDate =
                              entry.value;

                          return ExpansionTileCard(
                            expandedColor: Theme.of(context).canvasColor,
                            baseColor: Theme.of(context).canvasColor,
                            elevation: 0,
                            title: Text(
                              date == formatDateTime(DateTime.now().toString())
                                  ? "Today"
                                  : date,
                              style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                              ),
                            ),
                            trailing:  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).textTheme.headlineMedium?.color,),
                            children: notificationsForDate.map((notification) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/notification-badge.svg"),
                                        const SizedBox(width: 10),
                                        Text(
                                          notification["title"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineLarge
                                                ?.color,
                                            fontFamily: "PoppinsSemiBold",
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      notification["body"],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.color,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      formatDateTime(notification["createdAt"]),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffC3C3C3),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 60,
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            "Version: 1.0 All rights reserved ©FuelAlert ${DateTime.now().year}",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                                fontSize: 10.5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      );
    });
  }
}