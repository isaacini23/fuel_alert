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
import 'package:fuel_alert/screens/skeleton/station-skeleton.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

class AllView extends StatefulWidget {
  const AllView({super.key});

  @override
  State<AllView> createState() => _AllViewState();
}

class _AllViewState extends State<AllView> with SingleTickerProviderStateMixin {
  
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
    if (_scrollController.position.pixels ==
        (_scrollController.position.maxScrollExtent)) {
      setState(() {
        currentPage++;
      });
      _homeStateController.fetchMoreAllStationData(currentPage: currentPage);
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

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  int currentPage = 1;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    currentPage = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return EasyRefresh(
        onRefresh: () {
          controller.getAllStationsData();
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
                          "${controller.allStations.length} stations found",
                          style: const TextStyle(
                              color: Color(0xff828282),
                              fontFamily: "PoppinsMeds",
                              fontSize: 16),
                        ),
                        Row(
                          children: [
                            InkWell(onTap: () {
                              controller.updateSelectedMapViewType("");
                              controller
                                  .updateStationModel(controller.allStations[0]);
                              controller
                                  .updateStationModel(controller.allStations[0]);
                              controller.toggleIsMapVisible();
                              controller
                                  .updateMapViewStations(controller.allStations);
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
                              controller.refreshAllStationData();
                            }, child: GetBuilder<ThemeController>(
                                builder: (themeController) {
                              return Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).unselectedWidgetColor,
                                    shape: BoxShape.circle,
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
                                (controller.allStations.length + 1), (index) {
                              if (index == controller.allStations.length) {
                                return (controller.isFetchingMore)
                                    ? Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: const Center(
                                            child: CircularProgressIndicator()))
                                    : const SizedBox.shrink();
                              }
                    
                              List<String> stationTypes = List<String>.from(
                                  controller.allStations[index]["stationDetails"]
                                      ["stationType"]);
                              Map<String, dynamic> stationDetails =
                                  controller.allStations[index]["stationDetails"];
                    
                              num getPriceForFirstType(String type) {
                                switch (type) {
                                  case 'PetrolStation':
                                    return stationDetails["petrolPrice"] ?? 0.0;
                                  case 'DieselStation':
                                    return stationDetails["dieselPrice"] ?? 0.0;
                                  case 'GasStation':
                                    return stationDetails["gasPrice"] ?? 0.0;
                                  case 'KeroseneStation':
                                    return stationDetails["kerosene"] ?? 0.0;
                                  default:
                                    return 0;
                                }
                              }
                    
                              num firstTypePrice = getPriceForFirstType(
                                  stationTypes.isNotEmpty ? stationTypes.first : '');
                    
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
                                        controller.allStations[index]);
                                    Get.toNamed(stationDetailsScreen, arguments: {

                                    "type": stationTypes[0],
                                      "station": controller.station,
                                      "index": index,
                                      "listItem": controller.allStations
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
                                                controller.allStations[index]
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
                                                controller.allStations[index]
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
                                                      text: controller.allStations[
                                                                          index][
                                                                      "stationDetails"]
                                                                  [
                                                                  "openNowDisplay"] ==
                                                              "True"
                                                          ? "Open"
                                                          : "Closed ",
                                                      style: TextStyle(
                                                          color: controller.allStations[
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
                                                            controller.allStations[
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
                                                            controller.allStations[
                                                                        index]
                                                                    ["stationDetails"]
                                                                ["longitude"],
                                                        latitude:
                                                            controller.allStations[
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
                                                                  .allStations);
                                                    },
                                                    child: Icon(Icons.favorite,
                                                        color: controller.allStations[
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
                                      (firstTypePrice == 0)
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
                                                            .allStations[index]);
                                                    Get.toNamed(submitPriceScreen,
                                                        arguments: {
                                                          "type": stationTypes[0],
                                                          "station":
                                                              controller.station,
                                                          "index": index,
                                                          "listItem":
                                                              controller.allStations
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
                                                            style: const TextStyle(
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
                                                              const TextSpan(
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
                                                    controller.allStations[index]
                                                                    ["stationDetails"]
                                                                ["pumpAccuracy"] ==
                                                            "NoReport"
                                                        ? const SizedBox.shrink()
                                                        : SvgPicture.asset(
                                                            controller.allStations[index]
                                                                            ["stationDetails"][
                                                                        "pumpAccuracy"] ==
                                                                    "Excellent"
                                                                ? "assets/images/excellent-pump.svg"
                                                                : controller.allStations[index]
                                                                                ["stationDetails"]
                                                                            [
                                                                            "pumpAccuracy"] ==
                                                                        "Good"
                                                                    ? "assets/images/good-pump.svg"
                                                                    : controller.allStations[index]
                                                                                    ["stationDetails"]
                                                                                [
                                                                                "pumpAccuracy"] ==
                                                                            "Fair"
                                                                        ? "assets/images/fair-pump.svg"
                                                                        : controller.allStations[index]["stationDetails"]
                                                                                    ["pumpAccuracy"] ==
                                                                                "Poor"
                                                                            ? "assets/images/poor-pump.svg"
                                                                            : "",
                                                          ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    controller.allStations[index]
                                                                    ["stationDetails"]
                                                                ["queue"] ==
                                                            "NoReport"
                                                        ? const SizedBox.shrink()
                                                        : Text(
                                                            "${controller.convertRangeToMiddle(controller.allStations[index]["stationDetails"]["queue"])}+ people in queue",
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
                                                    Text(
                                                      controller.allStations[index]
                                                              ["stationDetails"]
                                                              ["stationType"][0]
                                                          .toString()
                                                          .replaceAll("Station", "")
                                                          .toUpperCase(),
                                                      style: const TextStyle(
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
                                                              text: controller.allStations[
                                                                                  index]
                                                                              [
                                                                              "stationDetails"]
                                                                          [
                                                                          "stationType"][0] ==
                                                                      "GasStation"
                                                                  ? "${controller.allStations[index]["stationDetails"]["gasPrice"]}/KG"
                                                                  : "$firstTypePrice/L",
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
                                                                    .allStations[
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
                                                          "(${controller.allStations[index]["stationDetails"]["noOfReviews"]} Reviews)",
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
                                                    (controller.allStations[index]
                                                                    ["stationDetails"]
                                                                [
                                                                "priceLastUpdated"] ==
                                                            null)
                                                        ? const SizedBox.shrink()
                                                        : Text(
                                                            timeago.format(DateTime.parse(
                                                                controller.allStations[
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
                          child: Text(
                            "${controller.allStations.length}",
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
                              onTap: _scrollToTop,
                              label: "Move up",
                            ),
                            SpeedDialChild(
                              onTap: (){
                                controller
                                      .updateStationModel(controller.allStations[0]);
                                  controller
                                      .updateStationModel(controller.allStations[0]);
                                  controller.toggleIsMapVisible();
                                  controller
                                      .updateMapViewStations(controller.allStations);
                              },
                              label: "View on map",
                            ),
                            SpeedDialChild(
                              onTap: () {
                                controller.refreshAllStationData();
                                _scrollToTop();
                                
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
