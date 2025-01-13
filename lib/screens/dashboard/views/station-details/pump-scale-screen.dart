import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/station-map-view.dart';
import 'package:fuel_alert/widget/bottoms/submit-pump-scale-confirmation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../models/station-model.dart';
import '../../../../widget/buttons/buttons.dart';

// ignore: must_be_immutable
class PumpScaleScreen extends StatelessWidget {
  PumpScaleScreen({super.key});

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
              "Pump Scale",
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
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
                            "How would you rate the pump meter?",
                            style: TextStyle(
                                color: Theme.of(context).iconTheme.color,
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.count(
                          primary: false,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          children: [
                            InkWell(
                              onTap: () {
                                controller
                                    .updateSelectedPumpAccuracy("Excellent");
                              },
                              child: Container(
                                height: 142,
                                width: 126,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: (controller.selectedPumpAccuracy ==
                                            "Excellent")
                                        ? Border.all(
                                            width: 1.5,
                                            color: const Color(0xff009933)
                                                .withOpacity(0.60))
                                        : null,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          offset: const Offset(0, 4.2),
                                          blurRadius: 30.72)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 0.87,
                                              color: const Color(0xff009933)
                                                  .withOpacity(0.20)),
                                          color: const Color(0xff009933)
                                              .withOpacity(0.05)),
                                      child: const Center(
                                        child: Icon(
                                          Iconsax.star,
                                          size: 28,
                                          color: Color(0xff009933),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Excellent",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.color,
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 22),
                                    ),
                                    const Text(
                                      "Pump meter",
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 15.45),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.updateSelectedPumpAccuracy("Good");
                              },
                              child: Container(
                                height: 142,
                                width: 126,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: (controller.selectedPumpAccuracy ==
                                            "Good")
                                        ? Border.all(
                                            width: 1.5,
                                            color: const Color(0xff009933)
                                                .withOpacity(0.60))
                                        : null,
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          offset: const Offset(0, 4.2),
                                          blurRadius: 30.72)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 0.87,
                                              color: const Color(0xff66BD50)
                                                  .withOpacity(0.20)),
                                          color: const Color(0xff66BD50)
                                              .withOpacity(0.05)),
                                      child: const Center(
                                        child: Icon(
                                          Iconsax.star,
                                          size: 28,
                                          color: Color(0xff66BD50),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Good",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.color,
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 22),
                                    ),
                                    const Text(
                                      "Pump meter",
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 15.45),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.updateSelectedPumpAccuracy("Fair");
                              },
                              child: Container(
                                height: 142,
                                width: 126,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: (controller.selectedPumpAccuracy ==
                                            "Fair")
                                        ? Border.all(
                                            width: 1.5,
                                            color: const Color(0xff009933)
                                                .withOpacity(0.60))
                                        : null,
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          offset: const Offset(0, 4.2),
                                          blurRadius: 30.72)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 0.87,
                                              color: const Color(0xffEBBC46)
                                                  .withOpacity(0.20)),
                                          color: const Color(0xffEBBC46)
                                              .withOpacity(0.05)),
                                      child: const Center(
                                        child: Icon(
                                          Iconsax.star,
                                          size: 28,
                                          color: Color(0xffEBBC46),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Fair",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.color,
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 22),
                                    ),
                                    const Text(
                                      "Pump meter",
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 15.45),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.updateSelectedPumpAccuracy("Poor");
                              },
                              child: Container(
                                height: 142,
                                width: 126,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    border: (controller.selectedPumpAccuracy ==
                                            "Poor")
                                        ? Border.all(
                                            width: 1.5,
                                            color: const Color(0xff009933)
                                                .withOpacity(0.60))
                                        : null,
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.10),
                                          offset: const Offset(0, 4.2),
                                          blurRadius: 30.72)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 65,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 0.87,
                                              color: const Color(0xffDE4841)
                                                  .withOpacity(0.20)),
                                          color: const Color(0xffDE4841)
                                              .withOpacity(0.05)),
                                      child: const Center(
                                        child: Icon(
                                          Iconsax.star,
                                          size: 28,
                                          color: Color(0xffDE4841),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Poor",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.color,
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 22),
                                    ),
                                    const Text(
                                      "Pump meter",
                                      style: TextStyle(
                                          color: Color(0xff999999),
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 15.45),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
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
                                    isLoading: false,
                                    title: "Confirm",
                                    action: 
                                    // (station.distance! > 100)
                                    //     ? null
                                    //     : 
                                        () {
                                            SubmitPumpScaleConfirmation().show(
                                                context,
                                                station.stationDetails!.id,
                                                listItem,
                                                index, currentStationType);
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
