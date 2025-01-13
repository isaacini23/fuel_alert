import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/routes/app/app-route-names.dart';

class RecentSearchView extends StatelessWidget {
  const RecentSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return Container(
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Recent Search",
                style: TextStyle(
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: (controller.recentSearchList.isEmpty)
                    ? const Center(
                        child: Text(
                          "No recent search",
                          style: TextStyle(
                              color: Color(0xff828282),
                              fontFamily: "PoppinsMeds",
                              fontSize: 16),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              controller.recentSearchList.length, (index) {
                            var recentSearch =
                                controller.recentSearchList[index];
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    controller.updateStationModel(
                                        controller.recentSearchList[index]);
                                    Get.toNamed(stationDetailsScreen,
                                        arguments: {
                                          "type": recentSearch["stationDetails"]["stationType"][0],
                                          "station": controller.station,
                                          "index": index,
                                          "listItem": controller.recentSearchList
                                        });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(
                                    Iconsax.search_normal_1,
                                    color: Color(0xffA3A3A3),
                                    size: 15,
                                  ),
                                  title: Text(
                                    recentSearch["stationDetails"]["name"],
                                    style: const TextStyle(
                                        color: Color(0xff828282),
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 16),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      controller.removeFromRecentSearchList(
                                          recentSearch);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Color(0xffA3A3A3),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xffF3F3F3),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
              )
            ],
          ),
        ),
      );
    });
  }
}
