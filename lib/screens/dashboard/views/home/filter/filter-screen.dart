import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/core/extensions/string-extensions.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    String formatTimeRange(String timeRange) {
      switch (timeRange) {
        case "OneToThirtyMin":
          return "1 - 30 min";
        case "ThirtyToTwoHrs":
          return "30 min - 2 hrs";
        case "TwoHrsToTwentyFourHrs":
          return "2 hrs - 24 hrs";
        case "OneDayTo7Days":
          return "1 day - 7 days";
        case "SevenDaysAndAbove":
          return "7 days and above";
        default:
          return "Invalid time range";
      }
    }

    return GetBuilder<HomeStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.resetFilters();
              },
              icon: const Icon(
                Iconsax.arrow_left,
              )),
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          title: Text(
            "Filter By",
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
          child: Column(
            children: [
              Expanded(
                flex: 13,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Products",
                              style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                              ),
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller.productFilter.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10
                              ), 
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:(context, index) {
                                String key = controller.productFilter.keys
                                    .elementAt(index);
                                bool value = controller.productFilter[key]!;
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: value,
                                      activeColor: const Color(0xff009933),
                                      onChanged: (bool? newValue) {
                                        controller.updateProductFilter(
                                            key: key, newValue: newValue);
                                      },
                                    ),
                                    Text(
                                      key.capitalizeAndAddSpace(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.color,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD6D6D6),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stations",
                              style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: controller.showOnlyOpenStations,
                                    activeColor: const Color(0xff009933),
                                    onChanged: (value) {
                                      controller.toggleStationFilter();
                                    }),
                                Text(
                                  "Show only open stations",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD6D6D6),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pump scale accuracy",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.updateSelectedPumpAccuracy("");
                                  },
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 14,
                                        color: Color(0xffDE4841)),
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller
                                          .pumpAccuracyCategory.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10
                              ), 
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:(context, index) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: controller
                                          .pumpAccuracyCategory[index],
                                      groupValue:
                                          controller.selectedPumpAccuracy,
                                      activeColor: const Color(0xff009933),
                                      onChanged: (String? newValue) {
                                        controller.updateSelectedPumpAccuracy(
                                            newValue);
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${controller.pumpAccuracyCategory[index]} pump scale",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.color),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD6D6D6),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
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
                                InkWell(
                                  onTap: () {
                                    controller.updateRatingFilter("");
                                  },
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 14,
                                        color: Color(0xffDE4841)),
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller
                                          .ratingFilter.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10
                              ), 
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:(context, index) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: controller.ratingFilter[index],
                                      groupValue:
                                          controller.selectedRatingFilter,
                                      activeColor: const Color(0xff009933),
                                      onChanged: (String? newValue) {
                                        controller.updateRatingFilter(newValue);
                                      },
                                    ),
                                    Text(
                                      "${controller.ratingFilter[index]}+ stars",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD6D6D6),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.updateDistanceFilter("");
                                    controller.clearDistance();
                                  },
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 14,
                                        color: Color(0xffDE4841)),
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller
                                          .distanceFilter.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10
                              ), 
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:(context, index) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: controller.distanceFilter[index],
                                      groupValue:
                                          controller.selectedDistanceFilter,
                                      activeColor: const Color(0xff009933),
                                      onChanged: (String? newValue) {
                                        controller
                                            .updateDistanceFilter(newValue);
                                        controller.updateMinDistance(
                                            newValue!.split(" - ").first);
                                        controller.updateMaxDistance(
                                            newValue.split(" - ").last);
                                      },
                                    ),
                                    Text(
                                      (controller.distanceFilter.last ==
                                              controller.distanceFilter[index])
                                          ? "${controller.distanceFilter[index]}m above"
                                          : "${controller.distanceFilter[index]}m",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD6D6D6),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.updatePriceFilter("");
                                    controller.clearPrice();
                                  },
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 14,
                                        color: Color(0xffDE4841)),
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller
                                          .priceFilter.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10
                              ), 
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:(context, index) {
                                  return Row(
                                  children: [
                                    Radio<String>(
                                      value: controller.priceFilter[index],
                                      groupValue:
                                          controller.selectedPriceFilter,
                                      activeColor: const Color(0xff009933),
                                      onChanged: (String? newValue) {
                                        controller.updatePriceFilter(newValue);
                                        controller.updateMinPrice(
                                            newValue!.split(" - ").first);
                                        controller.updateMaxPrice(
                                            newValue.split(" - ").last);
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "₦",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.color),
                                          children: [
                                            TextSpan(
                                              text: (controller
                                                          .priceFilter.last ==
                                                      controller
                                                          .priceFilter[index])
                                                  ? "${controller.priceFilter[index]} above"
                                                  : controller
                                                      .priceFilter[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.color),
                                            )
                                          ]),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffD6D6D6),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Last Updated",
                                  style: TextStyle(
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.updateSelectedTimeFilterValue("");
                                  },
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 14,
                                        color: Color(0xffDE4841)),
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller
                                          .timeFilterValues.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 20,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 10
                              ), 
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:(context, index) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: controller
                                          .timeFilterValues[index],
                                      groupValue:
                                          controller.selectedTimeFilterValue,
                                      activeColor: const Color(0xff009933),
                                      onChanged: (String? newValue) {
                                        controller.updateSelectedTimeFilterValue(
                                            newValue);
                                      },
                                    ),
                                    Text(
                                      formatTimeRange(controller.timeFilterValues[index]),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.color),
                                    ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Buttons().cancelButtons(
                          context,
                            title: "Reset",
                            action: () {
                              controller.resetFilters();
                            }),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Buttons().defaultButtons(
                            isLoading: controller.isLoading,
                            title: "Apply",
                            action: () {
                              controller.filterStation();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      );
    });
  }
}
