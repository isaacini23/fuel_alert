import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/models/station-model.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/station-map-view.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class StationDetailsView extends StatelessWidget {
  StationDetailsView({super.key});

  Station station = Get.arguments["station"];
  int index = Get.arguments["index"];
  List<dynamic> listItem = Get.arguments["listItem"];
  String currentStationType = Get.arguments["type"];
  final HomeStateController _homeStateController =
      Get.find<HomeStateController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      _homeStateController.getReviews(station.stationDetails!.id);
    });

    return GetBuilder<HomeStateController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.15),
            centerTitle: true,
            title: Text(
              "Station Details",
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
                              Text(
                                station.stationDetails!.address ?? "",
                                style: const TextStyle(
                                    color: Color(0xff999999),
                                    fontFamily: "PoppinsMeds",
                                    fontSize: 13),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Color(0xff009933),
                                            size: 18,
                                          ),
                                          Text(
                                            " ${controller.formatDistance(station.distance ?? 0.0)}",
                                            style: const TextStyle(
                                                color: Color(0xff999999),
                                                fontFamily: "PoppinsMeds",
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color: Color(0xff009933),
                                            size: 18,
                                          ),
                                          Text(
                                            " 0909845678",
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontFamily: "PoppinsMeds",
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.launchGoogleMaps(
                                        longitude:
                                            station.stationDetails!.longitude,
                                        latitude:
                                            station.stationDetails!.longitude,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).highlightColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/Time icon.svg"),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          const Text(
                                            "Navigation",
                                            style: TextStyle(
                                              color: Color(0xff9599AD),
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 11,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  // const Icon(
                                  //   Icons.access_time,
                                  //   color: Color(0xff009933),
                                  //   size: 18,
                                  // ),
                                  RichText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: station.stationDetails!
                                                  .openNowDisplay ==
                                              "True"
                                          ? "Open"
                                          : "Closed ",
                                      style: TextStyle(
                                          color: station.stationDetails!
                                                      .openNowDisplay ==
                                                  "True"
                                              ? Color(0xff009933)
                                              : Color(0xffDE4841),
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        station.stationDetails!.periods!.length,
                                        (index) {
                                      String periods = station
                                          .stationDetails!.periods![index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          periods,
                                          style: const TextStyle(
                                              color: Color(0xff828282),
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 12),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: Color(0xffF6F6F6),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prices",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: 15,
                                runSpacing: 20,
                                children: [
                                  Container(
                                    height: 106,
                                    width: 106,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.10),
                                              offset: const Offset(0, 3.53),
                                              blurRadius: 25.85)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "PETROL",
                                          style: TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 13,
                                              color: Color(0xff009933)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        listItem[index]["stationDetails"]
                                                    ["petrolPrice"] ==
                                                0
                                            ? Text(
                                                "Nil",
                                                style: TextStyle(
                                                  fontFamily: "PoppinsSemiBold",
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.color,
                                                ),
                                              )
                                            : AutoSizeText.rich(
                                                minFontSize: 5,
                                                maxLines: 1,
                                                TextSpan(
                                                    text: "₦",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "InterSemiBold",
                                                      fontSize: 24,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge
                                                          ?.color,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${listItem[index]["stationDetails"]["petrolPrice"]}/L",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "PoppinsSemiBold",
                                                          fontSize: 24,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineLarge
                                                                  ?.color,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (listItem[index]["stationDetails"]
                                                      ["isFuelInStock"] ==
                                                  null)
                                              ? "Not applicable"
                                              : (listItem[index]
                                                              ["stationDetails"]
                                                          ["isFuelInStock"] ==
                                                      false)
                                                  ? "Out of stock"
                                                  : "${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["priceLastUpdated"] ?? DateTime.now().toString()))}",
                                          style: const TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 10,
                                              color: Color(0xff999999)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 106,
                                    width: 106,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.10),
                                              offset: const Offset(0, 3.53),
                                              blurRadius: 25.85)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "DIESEL",
                                          style: TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 13,
                                              color: Color(0xff009933)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        listItem[index]["stationDetails"]
                                                    ["dieselPrice"] ==
                                                0
                                            ? Text(
                                                "Nil",
                                                style: TextStyle(
                                                  fontFamily: "PoppinsSemiBold",
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.color,
                                                ),
                                              )
                                            : AutoSizeText.rich(
                                                minFontSize: 5,
                                                maxLines: 1,
                                                TextSpan(
                                                    text: "₦",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "InterSemiBold",
                                                      fontSize: 24,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge
                                                          ?.color,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${listItem[index]["stationDetails"]["dieselPrice"]}/L",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "PoppinsSemiBold",
                                                          fontSize: 24,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineLarge
                                                                  ?.color,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (listItem[index]["stationDetails"]
                                                      ["isDieselInStock"] ==
                                                  null)
                                              ? "Not applicable"
                                              : (listItem[index]
                                                              ["stationDetails"]
                                                          ["isDieselInStock"] ==
                                                      false)
                                                  ? "Out of stock"
                                                  : "${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["priceLastUpdated"] ?? DateTime.now().toString()))}",
                                          style: const TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 10,
                                              color: Color(0xff999999)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 106,
                                    width: 106,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.10),
                                              offset: const Offset(0, 3.53),
                                              blurRadius: 25.85)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "KEROSENE",
                                          style: TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 13,
                                              color: Color(0xff009933)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        listItem[index]["stationDetails"]
                                                    ["kerosene"] ==
                                                0
                                            ? Text(
                                                "Nil",
                                                style: TextStyle(
                                                  fontFamily: "PoppinsSemiBold",
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.color,
                                                ),
                                              )
                                            : AutoSizeText.rich(
                                                minFontSize: 5,
                                                maxLines: 1,
                                                TextSpan(
                                                    text: "₦",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "InterSemiBold",
                                                      fontSize: 24,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge
                                                          ?.color,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "${listItem[index]["stationDetails"]["kerosene"]}/L",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "PoppinsSemiBold",
                                                          fontSize: 24,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineLarge
                                                                  ?.color,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (listItem[index]["stationDetails"]
                                                      ["isKeroseneInStock"] ==
                                                  null)
                                              ? "Not applicable"
                                              : (listItem[index]
                                                              ["stationDetails"]
                                                          [
                                                          "isKeroseneInStock"] ==
                                                      false)
                                                  ? "Out of stock"
                                                  : "${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["priceLastUpdated"] ?? DateTime.now().toString()))}",
                                          style: const TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 10,
                                              color: Color(0xff999999)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 106,
                                    width: 106,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.10),
                                              offset: const Offset(0, 3.53),
                                              blurRadius: 25.85)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const AutoSizeText(
                                          minFontSize: 10,
                                          maxLines: 1,
                                          "Cooking Gas",
                                          style: TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 13,
                                              color: Color(0xff009933)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        listItem[index]["stationDetails"]
                                                    ["gasPrice"] ==
                                                0
                                            ? Text(
                                                "Nil",
                                                style: TextStyle(
                                                  fontFamily: "PoppinsSemiBold",
                                                  fontSize: 24,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .headlineLarge
                                                      ?.color,
                                                ),
                                              )
                                            : AutoSizeText.rich(
                                                minFontSize: 5,
                                                maxLines: 1,
                                                TextSpan(
                                                    text: "₦",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "InterSemiBold",
                                                      fontSize: 24,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge
                                                          ?.color,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: station
                                                                    .stationDetails!
                                                                    .gasPrice ==
                                                                0
                                                            ? "Nil"
                                                            : "${listItem[index]["stationDetails"]["gasPrice"]}/KG",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "PoppinsSemiBold",
                                                          fontSize: 24,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineLarge
                                                                  ?.color,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (listItem[index]["stationDetails"]
                                                      ["isGasInStock"] ==
                                                  null)
                                              ? "Not applicable"
                                              : (listItem[index]
                                                              ["stationDetails"]
                                                          ["isGasInStock"] ==
                                                      false)
                                                  ? "Out of stock"
                                                  : "${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["priceLastUpdated"] ?? DateTime.now().toString()))}",
                                          style: const TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 10,
                                              color: Color(0xff999999)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              listItem[index]["stationDetails"]
                                          ["priceLastUpdatedBy"] ==
                                      null
                                  ? const Text(
                                      "Price not updated",
                                      style: TextStyle(
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 13,
                                          color: Color(0xff999999)),
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          "Submitted by ${listItem[index]["stationDetails"]["priceLastUpdatedBy"] ?? ""}",
                                          style: const TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 13,
                                              color: Color(0xff999999)),
                                        ),
                                        Text(
                                          "Updated ${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["priceLastUpdated"]))}",
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              color: Color(0xffC3C3C3)),
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 15,
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
                                        controller
                                            .formatDistance(station.distance!),
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
                              Buttons().defaultButtons(
                                  isLoading: false,
                                  title: "Submit Price",
                                  action: () {
                                    controller.fuelPrice.text = listItem[index]
                                            ["stationDetails"]["petrolPrice"]
                                        .toString();
                                    controller.dieselPrice.text =
                                        listItem[index]["stationDetails"]
                                                ["dieselPrice"]
                                            .toString();
                                    controller.gasPrice.text = listItem[index]
                                            ["stationDetails"]["gasPrice"]
                                        .toString();
                                    controller.kerosenePrice.text =
                                        listItem[index]["stationDetails"]
                                                ["kerosene"]
                                            .toString();
                                    controller.updateIsPetrolInStock(
                                        listItem[index]["stationDetails"]
                                                ["isFuelInStock"] ??
                                            false);
                                    controller.updateIsDieselInStock(
                                        listItem[index]["stationDetails"]
                                                ["isDieselInStock"] ??
                                            false);
                                    controller.updateIsKeroseneInStock(
                                        listItem[index]["stationDetails"]
                                                ["isKeroseneInStock"] ??
                                            false);
                                    controller.updateIsGasInStock(
                                        listItem[index]["stationDetails"]
                                                ["isGasInStock"] ??
                                            false);
                                    Get.toNamed(submitPriceScreen, arguments: {
                                      "type": currentStationType,
                                      "station": station,
                                      "index": index,
                                      "listItem": listItem
                                    });
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: Color(0xffF6F6F6),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Pump Accuracy Scale",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 250,
                                width: 250,
                                child: Stack(
                                  children: [
                                    SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum: 100,
                                          showLabels: false,
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                              startValue: 0,
                                              endValue: 25,
                                              color: const Color(
                                                  0xff009933), // Excellent
                                              startWidth: 15,
                                              endWidth: 15,
                                            ),
                                            GaugeRange(
                                              startValue: 25,
                                              endValue: 50,
                                              color: const Color(
                                                  0xff66BD50), // Excellent
                                              startWidth: 15,
                                              endWidth: 15,
                                            ),
                                            GaugeRange(
                                              startValue: 50,
                                              endValue: 75,
                                              color: const Color(
                                                  0xffF3A218), // Excellent
                                              startWidth: 15,
                                              endWidth: 15,
                                            ),
                                            GaugeRange(
                                              startValue: 75,
                                              endValue: 100,
                                              color: const Color(
                                                  0xffD42620), // Excellent
                                              startWidth: 15,
                                              endWidth: 15,
                                            ),
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: listItem[index]
                                                              ["stationDetails"]
                                                          ["pumpAccuracy"] ==
                                                      "Excellent"
                                                  ? 12.5
                                                  : listItem[index][
                                                                  "stationDetails"]
                                                              [
                                                              "pumpAccuracy"] ==
                                                          "Good"
                                                      ? 45
                                                      : listItem[index]
                                                                      ["stationDetails"]
                                                                  [
                                                                  "pumpAccuracy"] ==
                                                              "Fair"
                                                          ? 65
                                                          : listItem[index]
                                                                          ["stationDetails"]
                                                                      ["pumpAccuracy"] ==
                                                                  "Poor"
                                                              ? 90
                                                              : 0,
                                              needleColor:
                                                  const Color(0xffD0D5DD),
                                              needleStartWidth: 1,
                                              needleEndWidth: 4,
                                              needleLength: 0.8,
                                              knobStyle: const KnobStyle(
                                                color: Color(0xffD0D5DD),
                                                borderColor: Color(0xffD0D5DD),
                                                knobRadius: 0.07,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      bottom: 0,
                                      child: Text(
                                        "Excellent",
                                        style: TextStyle(
                                            color: Color(0xff626262),
                                            fontFamily: "PoppinsMeds"),
                                      ),
                                    ),
                                    const Positioned(
                                      right: 15,
                                      child: Text(
                                        "Fair",
                                        style: TextStyle(
                                            color: Color(0xff626262),
                                            fontFamily: "PoppinsMeds"),
                                      ),
                                    ),
                                    const Positioned(
                                      child: Text(
                                        "Good",
                                        style: TextStyle(
                                            color: Color(0xff626262),
                                            fontFamily: "PoppinsMeds"),
                                      ),
                                    ),
                                    const Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Text(
                                        "Poor",
                                        style: TextStyle(
                                            color: Color(0xff626262),
                                            fontFamily: "PoppinsMeds"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listItem[index]["stationDetails"]
                                                ["pumpAccuracy"] ==
                                            "NoReport"
                                        ? ""
                                        : "${listItem[index]["stationDetails"]["pumpAccuracy"]} Meter",
                                    style: TextStyle(
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 22,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.color,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 10, vertical: 5),
                                  //   decoration: BoxDecoration(
                                  //       color: Theme.of(context).highlightColor,
                                  //       borderRadius:
                                  //           BorderRadius.circular(50)),
                                  //   child: Row(
                                  //     children: [
                                  //       SvgPicture.asset(
                                  //         "assets/images/Home icon.svg",
                                  //         height: 15,
                                  //         width: 15,
                                  //       ),
                                  //       const SizedBox(
                                  //         width: 3,
                                  //       ),
                                  //       const Text(
                                  //         "Petrol",
                                  //         style: TextStyle(
                                  //             fontFamily: "PoppinsMeds",
                                  //             fontSize: 15.71,
                                  //             color: Color(0xff009933)),
                                  //       ),
                                  //       const SizedBox(
                                  //         width: 3,
                                  //       ),
                                  //       const Icon(
                                  //         Icons.keyboard_arrow_down,
                                  //         color: Color(0xff828282),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              listItem[index]["stationDetails"]
                                          ["reportLastUpdatedBy"] ==
                                      null
                                  ? const Text(
                                      "Pump accuracy not updated",
                                      style: TextStyle(
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 13,
                                          color: Color(0xff999999)),
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          "Submitted by ${listItem[index]["stationDetails"]["reportLastUpdatedBy"]}",
                                          style: const TextStyle(
                                              fontFamily: "PoppinsMeds",
                                              fontSize: 13,
                                              color: Color(0xff999999)),
                                        ),
                                        Text(
                                          "Updated ${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["reportLastUpdated"]))}",
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              color: Color(0xffC3C3C3)),
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              Buttons().defaultButtons(
                                  isLoading: false,
                                  title: "Submit Meter Report",
                                  action: () {
                                    Get.toNamed(pumpScaleScreen, arguments: {
                                      "type": currentStationType,
                                      "station": station,
                                      "index": index,
                                      "listItem": listItem
                                    });
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: Color(0xffF6F6F6),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Queue",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircularStepProgressIndicator(
                                totalSteps: 100,
                                currentStep: 100,
                                stepSize: 10,
                                selectedColor: const Color(0xff009933),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 150,
                                height: 150,
                                selectedStepSize: 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${controller.convertRangeToMiddle(listItem[index]["stationDetails"]["queue"])}+",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.color,
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 35.85),
                                    ),
                                    const Text(
                                      "vehicles",
                                      style: TextStyle(
                                          color: Color(0xff828282),
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 15.42),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${controller.convertRangeToMiddle(listItem[index]["stationDetails"]["queue"])}+ vehicles present at station",
                                style: const TextStyle(
                                    fontFamily: "PoppinsMeds",
                                    fontSize: 13,
                                    color: Color(0xff999999)),
                              ),
                              listItem[index]["stationDetails"]
                                          ["queueLastUpdated"] ==
                                      null
                                  ? const Text(
                                      "Queue not updated",
                                      style: TextStyle(
                                          fontFamily: "PoppinsMeds",
                                          fontSize: 13,
                                          color: Color(0xff999999)),
                                    )
                                  : Text(
                                      "Updated ${timeago.format(DateTime.parse(listItem[index]["stationDetails"]["queueLastUpdated"]))}",
                                      style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          color: Color(0xffC3C3C3)),
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              Buttons().defaultButtons(
                                  isLoading: false,
                                  title: "Submit Queue Report",
                                  action: () {
                                    Get.toNamed(queueReportScreen, arguments: {
                                      "type": currentStationType,
                                      "station": station,
                                      "index": index,
                                      "listItem": listItem
                                    });
                                  }),
                              const SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Ratings",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  controller.stationReviewsModel!
                                              .averageRating ==
                                          null
                                      ? "0.0"
                                      : controller
                                          .stationReviewsModel!.averageRating!
                                          .toDouble()
                                          .toString(),
                                  style: TextStyle(
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 60,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.color),
                                ),
                              ),
                              StarRating(
                                mainAxisAlignment: MainAxisAlignment.start,
                                starCount: 5,
                                rating: controller.stationReviewsModel!
                                            .averageRating ==
                                        null
                                    ? 0.0
                                    : controller
                                        .stationReviewsModel!.averageRating!
                                        .toDouble(),
                                onRatingChanged: (rating) {},
                                filledIcon: Icons.star,
                                allowHalfRating: false,
                                emptyIcon: Icons.star_outline,
                                size: 25,
                                color: const Color(0xffEF934D),
                                borderColor: const Color(0xffEF934D),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Price Rating",
                                  style: TextStyle(
                                      fontSize: 17, color: Color(0xffEF934D)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: controller
                                                  .stationReviewsModel!
                                                  .ratingPercentages ==
                                              null
                                          ? 0
                                          : controller.stationReviewsModel!
                                              .ratingPercentages!.the5!,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: const Color(0xff009933),
                                      unselectedColor: const Color(0xffD1D7DC),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: StarRating(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      starCount: 5,
                                      rating: 5,
                                      onRatingChanged: (rating) {},
                                      filledIcon: Icons.star,
                                      allowHalfRating: false,
                                      emptyIcon: Icons.star_outline,
                                      size: 18,
                                      color: const Color(0xffEF934D),
                                      borderColor: const Color(0xffEF934D),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${controller.stationReviewsModel!.ratingPercentages == null ? 0 : controller.stationReviewsModel!.ratingPercentages == null ? 0 : controller.stationReviewsModel!.ratingPercentages!.the5!}%",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.color),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: controller
                                                  .stationReviewsModel!
                                                  .ratingPercentages ==
                                              null
                                          ? 0
                                          : controller.stationReviewsModel!
                                              .ratingPercentages!.the4!,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: const Color(0xff009933),
                                      unselectedColor: const Color(0xffD1D7DC),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: StarRating(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      starCount: 5,
                                      rating: 4,
                                      onRatingChanged: (rating) {},
                                      filledIcon: Icons.star,
                                      allowHalfRating: false,
                                      emptyIcon: Icons.star_outline,
                                      size: 18,
                                      color: const Color(0xffEF934D),
                                      borderColor: const Color(0xffEF934D),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${controller.stationReviewsModel!.ratingPercentages == null ? 0 : controller.stationReviewsModel!.ratingPercentages!.the4!}%",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.color),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: controller
                                                  .stationReviewsModel!
                                                  .ratingPercentages ==
                                              null
                                          ? 0
                                          : controller.stationReviewsModel!
                                              .ratingPercentages!.the3!,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: const Color(0xff009933),
                                      unselectedColor: const Color(0xffD1D7DC),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: StarRating(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      starCount: 5,
                                      rating: 3,
                                      onRatingChanged: (rating) {},
                                      filledIcon: Icons.star,
                                      allowHalfRating: false,
                                      emptyIcon: Icons.star_outline,
                                      size: 18,
                                      color: const Color(0xffEF934D),
                                      borderColor: const Color(0xffEF934D),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${controller.stationReviewsModel!.ratingPercentages == null ? 0 : controller.stationReviewsModel!.ratingPercentages!.the3!}%",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.color),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: controller
                                                  .stationReviewsModel!
                                                  .ratingPercentages ==
                                              null
                                          ? 0
                                          : controller.stationReviewsModel!
                                              .ratingPercentages!.the2!,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: const Color(0xff009933),
                                      unselectedColor: const Color(0xffD1D7DC),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: StarRating(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      starCount: 5,
                                      rating: 2,
                                      onRatingChanged: (rating) {},
                                      filledIcon: Icons.star,
                                      allowHalfRating: false,
                                      emptyIcon: Icons.star_outline,
                                      size: 18,
                                      color: const Color(0xffEF934D),
                                      borderColor: const Color(0xffEF934D),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${controller.stationReviewsModel!.ratingPercentages == null ? 0 : controller.stationReviewsModel!.ratingPercentages!.the2!}%",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.color),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: controller
                                                  .stationReviewsModel!
                                                  .ratingPercentages ==
                                              null
                                          ? 0
                                          : controller.stationReviewsModel!
                                              .ratingPercentages!.the1!,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: const Color(0xff009933),
                                      unselectedColor: const Color(0xffD1D7DC),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: StarRating(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      starCount: 5,
                                      rating: 1,
                                      onRatingChanged: (rating) {},
                                      filledIcon: Icons.star,
                                      allowHalfRating: false,
                                      emptyIcon: Icons.star_outline,
                                      size: 18,
                                      color: const Color(0xffEF934D),
                                      borderColor: const Color(0xffEF934D),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${controller.stationReviewsModel!.ratingPercentages == null ? 0 : controller.stationReviewsModel!.ratingPercentages!.the1!}%",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.color),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Reviews",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              (controller.isLoading)
                                  ? const SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : (controller.stationReviews.isEmpty)
                                      ? const Text("No reviews yet")
                                      : Column(
                                          children: List.generate(
                                              controller.stationReviews.length,
                                              (index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const CircleAvatar(
                                                            radius: 25,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                controller.stationReviews[
                                                                        index][
                                                                    "userName"],
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        "PoppinsMeds",
                                                                    fontSize:
                                                                        16,
                                                                    color: Color(
                                                                        0xff757575)),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  StarRating(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    starCount:
                                                                        5,
                                                                    rating: controller
                                                                        .stationReviews[
                                                                            index]
                                                                            [
                                                                            "score"]
                                                                        .toDouble(),
                                                                    onRatingChanged:
                                                                        (rating) {},
                                                                    filledIcon:
                                                                        Icons
                                                                            .star,
                                                                    allowHalfRating:
                                                                        false,
                                                                    emptyIcon: Icons
                                                                        .star_outline,
                                                                    size: 11,
                                                                    color: const Color(
                                                                        0xffEF934D),
                                                                    borderColor:
                                                                        const Color(
                                                                            0xffEF934D),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  // const Text(
                                                                  //   "a month ago",
                                                                  //   style: TextStyle(
                                                                  //       fontFamily:
                                                                  //           "PoppinsMeds",
                                                                  //       fontSize:
                                                                  //           12,
                                                                  //       color: Color(
                                                                  //           0xffEF934D)),
                                                                  // ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        controller.stationReviews[
                                                                index]
                                                            ["reviewMessage"],
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff757575),
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Color(0xffD6D6D6),
                                                )
                                              ],
                                            );
                                          }),
                                        ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Buttons().borderButtons(context,
                                  title: "See more reviews", action: () {}),
                              const SizedBox(
                                height: 10,
                              ),
                              Buttons().defaultButtons(
                                  isLoading: false,
                                  title: "Leave a review",
                                  action: () {
                                    Get.toNamed(ratingAndReviewScreen,
                                        arguments: {
                                          "type": currentStationType,
                                          "station": station,
                                          "index": index,
                                          "listItem": listItem
                                        });
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Feel free to reach out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "PoppinsMeds",
                                fontSize: 18,
                                color: Color(0xff828282)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 53,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.launchUrls(
                                      "https://docs.google.com/forms/d/e/1FAIpQLSdrTpOcGkn3cIZodQ7eRRH9RdgpR_jQWVwjd4kVAFUrM8XIrg/viewform");
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/images/Chat.svg"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Contact us",
                                      style: TextStyle(
                                          color: Color(0xff009933),
                                          fontSize: 18,
                                          fontFamily: "PoppinsMeds"),
                                    ),
                                  ],
                                )),
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
