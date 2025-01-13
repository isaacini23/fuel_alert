import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/station-map-view.dart';
import 'package:get/get.dart';

import '../../../../models/station-model.dart';
import '../../../../widget/buttons/buttons.dart';

// ignore: must_be_immutable
class QueueReportScreen extends StatelessWidget {
  QueueReportScreen({super.key});

  Station station = Get.arguments["station"];
  int index = Get.arguments["index"];
  List<dynamic> listItem = Get.arguments["listItem"];
  String currentStationType = Get.arguments["type"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.15),
            centerTitle: true,
            title: Text(
              "Queue",
              style: TextStyle(
                  fontFamily: "PoppinsSemiBold",
                  fontSize: 24,
                  color: Theme.of(context).textTheme.titleLarge?.color),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3,
                    child: StationMapView(
                      currentStationType: currentStationType,
                      longitude: station.stationDetails!.longitude!,
                      latitude: station.stationDetails!.latitude!,
                      name: station.stationDetails!.name!,
                    )),
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      station.stationDetails!.name ?? "",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.color,
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.toggleSelectedFavoriteList(
                                          index: index, listItem: listItem);
                                    },
                                    child: Icon(Icons.favorite,
                                        color: listItem[index]["stationDetails"]
                                                ["isFavorite"]
                                            ? const Color(0xff009933)
                                            : const Color(0xff9C9C9C)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                station.stationDetails!.address ?? "",
                                style: const TextStyle(
                                    color: Color(0xff999999),
                                    fontFamily: "PoppinsMeds",
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                color: Color(0xffD6D6D6),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   padding: const EdgeInsets.all(15),
                              //   decoration: BoxDecoration(
                              //       color: const Color(0xffEBBC46)
                              //           .withOpacity(0.06)),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: RichText(
                              //           text: TextSpan(
                              //               text: "You have ",
                              //               style: TextStyle(
                              //                   color: Theme.of(context)
                              //                       .textTheme
                              //                       .titleMedium
                              //                       ?.color,
                              //                   fontFamily: "Poppins",
                              //                   fontSize: 10),
                              //               children: [
                              //                 TextSpan(
                              //                     text: "1000 ",
                              //                     style: TextStyle(
                              //                         color: Color(0xff009933),
                              //                         fontFamily: "PoppinsMeds",
                              //                         fontSize: 10)),
                              //                 TextSpan(
                              //                     text:
                              //                         "submissions remaining. You have used ",
                              //                     style: TextStyle(
                              //                         color: Theme.of(context)
                              //                             .textTheme
                              //                             .titleMedium
                              //                             ?.color,
                              //                         fontFamily: "Poppins",
                              //                         fontSize: 10)),
                              //                 TextSpan(
                              //                     text: "0 ",
                              //                     style: TextStyle(
                              //                         color: Theme.of(context)
                              //                             .textTheme
                              //                             .titleMedium
                              //                             ?.color,
                              //                         fontFamily: "PoppinsMeds",
                              //                         fontSize: 10)),
                              //                 TextSpan(
                              //                     text: "out of your ",
                              //                     style: TextStyle(
                              //                         color: Theme.of(context)
                              //                             .textTheme
                              //                             .titleMedium
                              //                             ?.color,
                              //                         fontFamily: "Poppins",
                              //                         fontSize: 10)),
                              //                 TextSpan(
                              //                     text: "1000 ",
                              //                     style: TextStyle(
                              //                         color: Theme.of(context)
                              //                             .textTheme
                              //                             .titleMedium
                              //                             ?.color,
                              //                         fontFamily: "PoppinsMeds",
                              //                         fontSize: 10)),
                              //                 TextSpan(
                              //                     text:
                              //                         "price submissions for today.",
                              //                     style: TextStyle(
                              //                         color: Theme.of(context)
                              //                             .textTheme
                              //                             .titleMedium
                              //                             ?.color,
                              //                         fontFamily: "Poppins",
                              //                         fontSize: 10)),
                              //               ]),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 15,
                              //       ),
                              //       const Icon(
                              //         Icons.info,
                              //         color: Color(0xffA3A3A3),
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "How many vehicles are queued?",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioListTile(
                          value: "NoQueue",
                          groupValue: controller.selectedQueueReport,
                          activeColor: const Color(0xff009933),
                          onChanged: (value) {
                            controller.updateSelectedQueueReport(value);
                          },
                          title: Text(
                            "No vehicles",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                                fontFamily: "PoppinsMeds",
                                fontSize: 14),
                          ),
                        ),
                        RadioListTile(
                          value: "OneToTen",
                          groupValue: controller.selectedQueueReport,
                          activeColor: const Color(0xff009933),
                          onChanged: (value) {
                            controller.updateSelectedQueueReport(value);
                          },
                          title: Text(
                            "1 to 10 vehicles",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                                fontFamily: "PoppinsMeds",
                                fontSize: 14),
                          ),
                        ),
                        RadioListTile(
                          value: "TenToTwenty",
                          groupValue: controller.selectedQueueReport,
                          activeColor: const Color(0xff009933),
                          onChanged: (value) {
                            controller.updateSelectedQueueReport(value);
                          },
                          title: Text(
                            "10 to 20 vehicles",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                                fontFamily: "PoppinsMeds",
                                fontSize: 14),
                          ),
                        ),
                        RadioListTile(
                          value: "TwentyToFifty",
                          groupValue: controller.selectedQueueReport,
                          activeColor: const Color(0xff009933),
                          onChanged: (value) {
                            controller.updateSelectedQueueReport(value);
                          },
                          title: Text(
                            "20 to 50 vehicles",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                                fontFamily: "PoppinsMeds",
                                fontSize: 14),
                          ),
                        ),
                        RadioListTile(
                          value: "MoreThanFifty",
                          groupValue: controller.selectedQueueReport,
                          activeColor: const Color(0xff009933),
                          onChanged: (value) {
                            controller.updateSelectedQueueReport(value);
                          },
                          title: Text(
                            "More than 50 vehicles",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                                fontFamily: "PoppinsMeds",
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            (station.distance! > 100)
                                ? "You’re far from station stay within 100m"
                                : "You’re close enough to confirm",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "PoppinsMeds",
                                fontSize: 15,
                                color: (station.distance! < 100)
                                    ? const Color(0xff009933)
                                    : const Color(0xffDE4841)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Distance to station -",
                              style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Color(0xff009933),
                                  size: 18,
                                ),
                                Text(
                                  controller.formatDistance(station.distance!),
                                  style: const TextStyle(
                                      fontFamily: "PoppinsMeds",
                                      fontSize: 15.71,
                                      color: Color(0xff009933)),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Buttons().cancelButtons(context,
                                    title: "Cancel", action: () {
                                  Navigator.pop(context);
                                }),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Buttons().defaultButtons(
                                    isLoading: controller.isLoading,
                                    title: "Confirm",
                                    action: 
                                    // (station.distance! > 100)
                                    //     ? null
                                    //     : 
                                        () {
                                            (controller.selectedQueueReport
                                                    .isEmpty)
                                                ? null
                                                : controller.submitQueueReport(
                                                context,
                                                    id: station
                                                        .stationDetails!.id,
                                                    listItem: listItem,
                                                    index: index);
                                          }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
