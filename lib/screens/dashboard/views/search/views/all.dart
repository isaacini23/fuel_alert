import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/screens/skeleton/station-skeleton.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:iconsax/iconsax.dart';

class SearchAllView extends StatefulWidget {
  const SearchAllView({super.key});

  @override
  State<SearchAllView> createState() => _SearchAllViewState();
}

class _SearchAllViewState extends State<SearchAllView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Search Results",
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
                    "${controller.allSearchStations.length} stations found",
                    style: const TextStyle(
                        color: Color(0xff828282),
                        fontFamily: "PoppinsMeds",
                        fontSize: 16),
                  ),
                  Row(
                    children: [
                      InkWell(onTap: () {
                        controller.updateSelectedMapViewType("");
                        controller.updateStationModel(
                            controller.allSearchStations[0]);
                        controller.updateStationModel(
                            controller.allSearchStations[0]);
                        controller.toggleIsMapVisible();
                        controller.updateMapViewStations(
                            controller.allSearchStations);
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
                          (controller.allSearchStations.length + 1), (index) {
                        if (index == controller.allSearchStations.length) {
                          return (controller.isFetchingMore)
                              ? Container(
                                  height: 100,
                                  width: double.infinity,
                                  child: const Center(
                                      child: CircularProgressIndicator()))
                              : const SizedBox.shrink();
                        }

                        List<String> stationTypes = List<String>.from(
                            controller.allSearchStations[index]
                                ["stationDetails"]["stationType"]);
                        Map<String, dynamic> stationDetails = controller
                            .allSearchStations[index]["stationDetails"];

                        // A function to get the price based on the first type only
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

                        // Check price for the first type only
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
                              controller.addToRecentSearchList(
                                  controller.allSearchStations[index]);
                              controller.updateStationModel(
                                  controller.allSearchStations[index]);
                              Get.toNamed(stationDetailsScreen, arguments: {

"type": stationTypes[0],
                                "station": controller.station,
                                "index": index,
                                "listItem": controller.allSearchStations
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
                                          controller.allSearchStations[index]
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
                                          controller.allSearchStations[index]
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
                                                text: controller.allSearchStations[
                                                                    index][
                                                                "stationDetails"]
                                                            [
                                                            "openNowDisplay"] ==
                                                        "True"
                                                    ? "Open"
                                                    : "Closed ",
                                                style: TextStyle(
                                                    color: controller.allSearchStations[
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
                                                      controller
                                                              .allSearchStations[
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
                                                  longitude: controller
                                                              .allSearchStations[
                                                          index]["stationDetails"]
                                                      ["longitude"],
                                                  latitude: controller
                                                              .allSearchStations[
                                                          index]["stationDetails"]
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
                                                            .allSearchStations);
                                              },
                                              child: Icon(Icons.favorite,
                                                  color: controller.allSearchStations[
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
                                                      .allSearchStations[index]);
                                              Get.toNamed(submitPriceScreen,
                                                  arguments: {
                                                     "type": stationTypes[0],
                                                    "station": controller.station,
                                                    "index": index,
                                                    "listItem": controller
                                                        .allSearchStations
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
                                                        offset:
                                                            const Offset(0, 3.53),
                                                        blurRadius: 25.85,
                                                        spreadRadius: 0,
                                                        color: Colors.black
                                                            .withOpacity(0.10)),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
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
                                              color: Theme.of(context).hoverColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0, 3.53),
                                                    blurRadius: 25.85,
                                                    spreadRadius: 0,
                                                    color: Colors.black
                                                        .withOpacity(0.10)),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              controller.allSearchStations[index]
                                                              ["stationDetails"]
                                                          ["pumpAccuracy"] ==
                                                      "NoReport"
                                                  ? const SizedBox.shrink()
                                                  : SvgPicture.asset(
                                                      controller.allSearchStations[index]
                                                                      ["stationDetails"][
                                                                  "pumpAccuracy"] ==
                                                              "Excellent"
                                                          ? "assets/images/excellent-pump.svg"
                                                          : controller.allSearchStations[index]
                                                                          ["stationDetails"]
                                                                      [
                                                                      "pumpAccuracy"] ==
                                                                  "Good"
                                                              ? "assets/images/good-pump.svg"
                                                              : controller.allSearchStations[index]
                                                                              ["stationDetails"]
                                                                          [
                                                                          "pumpAccuracy"] ==
                                                                      "Fair"
                                                                  ? "assets/images/fair-pump.svg"
                                                                  : controller.allSearchStations[index]["stationDetails"]
                                                                              ["pumpAccuracy"] ==
                                                                          "Poor"
                                                                      ? "assets/images/poor-pump.svg"
                                                                      : "",
                                                    ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              controller.allSearchStations[index]
                                                              ["stationDetails"]
                                                          ["queue"] ==
                                                      "NoReport"
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      "${controller.convertRangeToMiddle(controller.allSearchStations[index]["stationDetails"]["queue"])}+ people in queue",
                                                      textAlign: TextAlign.center,
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
                                                controller
                                                    .allSearchStations[index]
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
                                                        text: controller.allSearchStations[
                                                                            index]
                                                                        [
                                                                        "stationDetails"]
                                                                    [
                                                                    "stationType"][0] ==
                                                                "GasStation"
                                                            ? "${controller.allSearchStations[index]["stationDetails"]["gasPrice"]}/KG"
                                                            : "$firstTypePrice/L",
                                                        style: TextStyle(
                                                            color:
                                                                Theme.of(context)
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
                                                            BorderRadius.circular(
                                                                3.42),
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
                                                              .allSearchStations[
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
                                                    "(${controller.allSearchStations[index]["stationDetails"]["noOfReviews"]} Reviews)",
                                                    style: const TextStyle(
                                                        color: Color(0xff009933),
                                                        fontSize: 9),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              (controller.allSearchStations[index]
                                                              ["stationDetails"]
                                                          ["priceLastUpdated"] ==
                                                      null)
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      timeago.format(DateTime.parse(
                                                          controller.allSearchStations[
                                                                      index][
                                                                  "stationDetails"]
                                                              [
                                                              "priceLastUpdated"])),
                                                      textAlign: TextAlign.center,
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
      );
    });
  }
}
