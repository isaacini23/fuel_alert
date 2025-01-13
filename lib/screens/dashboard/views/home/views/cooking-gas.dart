import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../../skeleton/station-skeleton.dart';

class CookingGasView extends StatefulWidget {
  const CookingGasView({super.key});

  @override
  State<CookingGasView> createState() => _CookingGasViewState();
}

class _CookingGasViewState extends State<CookingGasView> with SingleTickerProviderStateMixin{
  final ScrollController _scrollController = ScrollController();
  
  final HomeStateController _homeStateController =
      Get.find<HomeStateController>();
  bool _showFab = false;


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }
  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _homeStateController.loadMoreGasStations();
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (!_showFab) {
        setState(() {
          _showFab = true;
        });
      }
    } else {
      if (_showFab) {
        setState(() {
          _showFab = false;
        });
      }
    }
  }

   void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return EasyRefresh(
        onRefresh: () {
          controller.getGasStations();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Nearby Filling Stations",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headlineMedium?.color,
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 28),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${controller.gasStations.length} stations found",
                          style: const TextStyle(
                              color: Color(0xff828282),
                              fontFamily: "PoppinsMeds",
                              fontSize: 16),
                        ),
                        Row(
                          children: [
                            InkWell(onTap: () {
                              controller.updateSelectedMapViewType("GasStation");
                              controller
                                  .updateStationModel(controller.gasStations[0]);
                              controller
                                  .updateStationModel(controller.gasStations[0]);
                              controller.toggleIsMapVisible();
                              controller
                                  .updateMapViewStations(controller.gasStations);
                            }, child: GetBuilder<ThemeController>(
                                builder: (themeController) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                      color: Theme.of(context).unselectedWidgetColor,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Theme.of(context).dialogBackgroundColor
                                    )),
                                child: const Text(
                                  "View on map",
                                  style: TextStyle(
                                      color: Color(0xff009933),
                                      fontFamily: "PoppinsMeds",
                                      fontSize: 14),
                                ),
                              );
                            })),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(onTap: () {
                              controller.refreshGasStations();
                            }, child: GetBuilder<ThemeController>(
                                builder: (themeController) {
                              return Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                      color: Theme.of(context).unselectedWidgetColor,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Theme.of(context).dialogBackgroundColor
                                    )),
                                child: const Icon(
                                  Icons.refresh,
                                  color: Color(0xff009933),
                                ),
                              );
                            })),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (controller.isLoading)
                        ? const StationSkeleton()
                        : Column(
                            children: List.generate(
                                (controller.gasStations.length + 1), (index) {
                              if (index == controller.gasStations.length) {
                                return (controller.isFetchingMore)
                                    ? Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: const Center(
                                            child: CircularProgressIndicator()))
                                    : const SizedBox.shrink();
                              }
                    
           
                              Map<String, dynamic> stationDetails =
                                  controller.gasStations[index]["stationDetails"];
                    
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 4.24),
                                          blurRadius: 31.24,
                                          spreadRadius: 0,
                                          color: Colors.black.withOpacity(0.05)),
                                    ],
                                    borderRadius: BorderRadius.circular(12)),
                                child: InkWell(
                                  onTap: () {
                                    controller.updateStationModel(
                                        controller.gasStations[index]);
                                    Get.toNamed(stationDetailsScreen, arguments: {
"type": "GasStation",
                                      "station": controller.station,
                                      "index": index,
                                      "listItem": controller.gasStations
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.gasStations[index]
                                                        ["stationDetails"]["name"]
                                                    .toString()
                                                    .toUpperCase(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .headlineLarge
                                                        ?.color,
                                                    fontFamily: "PoppinsSemiBold",
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                controller.gasStations[index]
                                                        ["stationDetails"]["address"]
                                                    .toString()
                                                    .capitalizeFirst!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Color(0xff999999),
                                                    fontFamily: "PoppinsMeds",
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  RichText(
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: controller.gasStations[
                                                                          index][
                                                                      "stationDetails"]
                                                                  [
                                                                  "openNowDisplay"] ==
                                                              "True"
                                                          ? "Open"
                                                          : "Closed ",
                                                      style: TextStyle(
                                                          color: controller.gasStations[
                                                                              index][
                                                                          "stationDetails"]
                                                                      [
                                                                      "openNowDisplay"] ==
                                                                  "True"
                                                              ? const Color(
                                                                  0xff009933)
                                                              : const Color(
                                                                  0xffDE4841),
                                                          fontFamily: "PoppinsMeds",
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Color(0xff009933),
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      AutoSizeText(
                                                        controller.formatDistance(
                                                            controller.gasStations[
                                                                index]["distance"]),
                                                        minFontSize: 8,
                                                        style: const TextStyle(
                                                            color: Color(0xff999999),
                                                            fontFamily: "PoppinsMeds",
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.launchGoogleMaps(
                                                        longitude:
                                                            controller.gasStations[
                                                                        index]
                                                                    ["stationDetails"]
                                                                ["longitude"],
                                                        latitude:
                                                            controller.gasStations[
                                                                        index]
                                                                    ["stationDetails"]
                                                                ["latitude"],
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                          color: Theme.of(context)
                                                              .highlightColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  50)),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/images/Time icon.svg"),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          const AutoSizeText(
                                                            minFontSize: 7,
                                                            maxLines: 1,
                                                            "Navigation",
                                                            style: TextStyle(
                                                              color:
                                                                  Color(0xff9599AD),
                                                              fontFamily:
                                                                  "PoppinsMeds",
                                                              fontSize: 11,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .toggleSelectedFavoriteList(
                                                              index: index,
                                                              listItem: controller
                                                                  .gasStations);
                                                    },
                                                    child: Icon(Icons.favorite,
                                                        color: controller.gasStations[
                                                                        index]
                                                                    ["stationDetails"]
                                                                ["isFavorite"]
                                                            ? const Color(0xff009933)
                                                            : const Color(
                                                                0xff9C9C9C)),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      (stationDetails["gasPrice"] == 0)
                                          ? Expanded(
                                              flex: 4,
                                              child: DottedBorder(
                                                borderType: BorderType.RRect,
                                                radius: const Radius.circular(10),
                                                color: const Color(0xffB0DFC0),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.updateStationModel(
                                                        controller
                                                            .gasStations[index]);
                                                    Get.toNamed(submitPriceScreen,
                                                        arguments: {
                                                          "type": "GasStation",
                                                          "station":
                                                              controller.station,
                                                          "index": index,
                                                          "listItem":
                                                              controller.gasStations
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 111,
                                                    padding: const EdgeInsets.all(15),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .hoverColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              offset: const Offset(
                                                                  0, 3.53),
                                                              blurRadius: 25.85,
                                                              spreadRadius: 0,
                                                              color: Colors.black
                                                                  .withOpacity(0.10)),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    child: Center(
                                                      child: AutoSizeText.rich(
                                                        minFontSize: 5,
                                                        textAlign: TextAlign.center,
                                                        TextSpan(
                                                            text: "Be the first to\n",
                                                            style: TextStyle(
                                                                color:
                                                                    Color(0xff009933),
                                                                fontFamily:
                                                                    "PoppinsMeds",
                                                                fontSize: 12),
                                                            children: [
                                                              TextSpan(
                                                                text: "Update\n",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headlineLarge
                                                                        ?.color,
                                                                    fontFamily:
                                                                        "PoppinsSemiBold",
                                                                    fontSize: 21),
                                                              ),
                                                              TextSpan(
                                                                text: "the price 😇",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff999999),
                                                                    fontFamily:
                                                                        "PoppinsMeds",
                                                                    fontSize: 12),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 5,
                                              child: Container(
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Theme.of(context).hoverColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset:
                                                              const Offset(0, 3.53),
                                                          blurRadius: 25.85,
                                                          spreadRadius: 0,
                                                          color: Colors.black
                                                              .withOpacity(0.10)),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Column(
                                                  children: [
                                                    controller.gasStations[index]
                                                                    ["stationDetails"]
                                                                ["pumpAccuracy"] ==
                                                            "NoReport"
                                                        ? const SizedBox.shrink()
                                                        : SvgPicture.asset(
                                                            controller.gasStations[index]
                                                                            ["stationDetails"][
                                                                        "pumpAccuracy"] ==
                                                                    "Excellent"
                                                                ? "assets/images/excellent-pump.svg"
                                                                : controller.gasStations[index]
                                                                                ["stationDetails"]
                                                                            [
                                                                            "pumpAccuracy"] ==
                                                                        "Good"
                                                                    ? "assets/images/good-pump.svg"
                                                                    : controller.gasStations[index]
                                                                                    ["stationDetails"]
                                                                                [
                                                                                "pumpAccuracy"] ==
                                                                            "Fair"
                                                                        ? "assets/images/fair-pump.svg"
                                                                        : controller.gasStations[index]["stationDetails"]
                                                                                    ["pumpAccuracy"] ==
                                                                                "Poor"
                                                                            ? "assets/images/poor-pump.svg"
                                                                            : "",
                                                          ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    controller.gasStations[index]
                                                                    ["stationDetails"]
                                                                ["queue"] ==
                                                            "NoReport"
                                                        ? const SizedBox.shrink()
                                                        : Text(
                                                            "${controller.convertRangeToMiddle(controller.gasStations[index]["stationDetails"]["queue"])}+ people in queue",
                                                            textAlign:
                                                                TextAlign.center,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                color:
                                                                    Color(0xff999999),
                                                                fontFamily:
                                                                    "PoppinsMeds",
                                                                fontSize: 9),
                                                          ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    const AutoSizeText(
                                                      minFontSize: 5,
                                                      maxLines: 1,
                                                      "GAS",
                                                      style: TextStyle(
                                                          color: Color(0XFF009933),
                                                          fontFamily: "PoppinsMeds",
                                                          fontSize: 13),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    AutoSizeText.rich(
                                                      minFontSize: 5,
                                                      maxLines: 1,
                                                      TextSpan(
                                                          text: "₦",
                                                          style: TextStyle(
                                                              color: Theme.of(context)
                                                                  .textTheme
                                                                  .headlineLarge
                                                                  ?.color,
                                                              fontFamily:
                                                                  "InterSemiBold",
                                                              fontSize: 24),
                                                          children: [
                                                            TextSpan(
                                                              text: "${controller.gasStations[index]["stationDetails"]["gasPrice"]}/KG",
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headlineLarge
                                                                      ?.color,
                                                                  fontFamily:
                                                                      "PoppinsSemiBold",
                                                                  fontSize: 24),
                                                            )
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets.all(3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(3.42),
                                                              color: const Color(
                                                                      0xff009933)
                                                                  .withOpacity(0.05)),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Iconsax.star5,
                                                                size: 9,
                                                                color:
                                                                    Color(0xff009933),
                                                              ),
                                                              const SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                controller
                                                                    .gasStations[
                                                                        index][
                                                                        "stationDetails"]
                                                                        ["rating"]
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff009933),
                                                                    fontSize: 9),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "(${controller.gasStations[index]["stationDetails"]["noOfReviews"]} Reviews)",
                                                          style: const TextStyle(
                                                              color:
                                                                  Color(0xff009933),
                                                              fontSize: 9),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    (controller.gasStations[index]
                                                                    ["stationDetails"]
                                                                [
                                                                "priceLastUpdated"] ==
                                                            null)
                                                        ? const SizedBox.shrink()
                                                        : Text(
                                                            timeago.format(DateTime.parse(
                                                                controller.gasStations[
                                                                            index][
                                                                        "stationDetails"]
                                                                    [
                                                                    "priceLastUpdated"])),
                                                            textAlign:
                                                                TextAlign.center,
                                                            maxLines: 2,
                                                            style: const TextStyle(
                                                                color:
                                                                    Color(0xff999999),
                                                                fontFamily:
                                                                    "PoppinsMeds",
                                                                fontSize: 10),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              if (_showFab)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        FloatingActionButton.small(
                          onPressed: (){},
                          elevation: 0,
                          backgroundColor: const Color(0xff009933),
                          shape: const CircleBorder(),
                          child: Text(
                            "${controller.gasStations.length}",
                            style: const TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SpeedDial(
                          overlayOpacity: 0,
                          backgroundColor: const Color(0xff009933),
                          children: [
                            SpeedDialChild(
                              onTap: scrollToTop,
                              label: "Move up",
                            ),
                            SpeedDialChild(
                              onTap: (){
                                controller
                                      .updateStationModel(controller.gasStations[0]);
                                  controller
                                      .updateStationModel(controller.gasStations[0]);
                                  controller.toggleIsMapVisible();
                                  controller
                                      .updateMapViewStations(controller.gasStations);
                              },
                              label: "View on map",
                            ),
                            SpeedDialChild(
                              onTap: () {
                                controller.refreshGasStations();
                                scrollToTop();
                              },
                              label: "Refresh",
                            ),
                          ],
                          child: const Icon(Icons.add, color: Colors.white,),
                        ),
                      ],
                    ),
                  )
                ),
            ],
          ),
        ),
      );
    });
  }
}
