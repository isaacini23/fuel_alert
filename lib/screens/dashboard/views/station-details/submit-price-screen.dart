import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/models/station-model.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/station-map-view.dart';
import 'package:fuel_alert/widget/bottoms/submit-price-confirmation.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SubmitPriceScreen extends StatelessWidget {
  SubmitPriceScreen({super.key});

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
              "Submit Price",
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
                          height: 15,
                        ),
                        const Divider(
                          color: Color(0xffF6F6F6),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Petrol (L)",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge
                                                  ?.color,
                                              fontSize: 20,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "In stock",
                                              style: TextStyle(
                                                color: Color(0xff009933),
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch.adaptive(
                                                value:
                                                    controller.isPetrolInStock,
                                                activeColor:
                                                    const Color(0xff009933),
                                                onChanged: (value) {
                                                  controller
                                                      .toggleIsPetrolInStock();
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: controller.fuelPrice,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Enter price",
                                        prefixIcon: const SizedBox(
                                          height: 36,
                                          width: 14,
                                          child: Center(
                                            child: Text(
                                              "₦",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xff9C9C9C),
                                                  fontFamily: "InterSemiBold"),
                                            ),
                                          ),
                                        ),
                                        fillColor: Theme.of(context)
                                            .inputDecorationTheme
                                            .fillColor,
                                        filled: true,
                                        hintStyle: const TextStyle(
                                            color: Color(0xffCCCCCC),
                                            fontSize: 16),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffD6D6D6),
                                                width: 0.76),
                                            borderRadius:
                                                BorderRadius.circular(6.1)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff009933),
                                                width: 0.76)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffFF0000),
                                                width: 0.76)),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffFF0000),
                                                    width: 0.76)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Diesel (L)",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge
                                                  ?.color,
                                              fontSize: 20,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "In stock",
                                              style: TextStyle(
                                                color: Color(0xff009933),
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch.adaptive(
                                                value:
                                                    controller.isDieselInStock,
                                                activeColor:
                                                    const Color(0xff009933),
                                                onChanged: (value) {
                                                  controller
                                                      .toggleIsDieselInStock();
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: controller.dieselPrice,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Enter price",
                                        prefixIcon: const SizedBox(
                                          height: 36,
                                          width: 14,
                                          child: Center(
                                            child: Text(
                                              "₦",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xff9C9C9C),
                                                  fontFamily: "InterSemiBold"),
                                            ),
                                          ),
                                        ),
                                        fillColor: Theme.of(context)
                                            .inputDecorationTheme
                                            .fillColor,
                                        filled: true,
                                        hintStyle: const TextStyle(
                                            color: Color(0xffCCCCCC),
                                            fontSize: 16),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffD6D6D6),
                                                width: 0.76),
                                            borderRadius:
                                                BorderRadius.circular(6.1)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff009933),
                                                width: 0.76)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffFF0000),
                                                width: 0.76)),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffFF0000),
                                                    width: 0.76)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Kerosene (L)",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge
                                                  ?.color,
                                              fontSize: 20,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "In stock",
                                              style: TextStyle(
                                                color: Color(0xff009933),
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch.adaptive(
                                                value: controller
                                                    .isKeroseneInStock,
                                                activeColor:
                                                    const Color(0xff009933),
                                                onChanged: (value) {
                                                  controller
                                                      .toggleIsKeroseneInStock();
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: controller.kerosenePrice,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Enter price",
                                        prefixIcon: const SizedBox(
                                          height: 36,
                                          width: 14,
                                          child: Center(
                                            child: Text(
                                              "₦",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xff9C9C9C),
                                                  fontFamily: "InterSemiBold"),
                                            ),
                                          ),
                                        ),
                                        fillColor: Theme.of(context)
                                            .inputDecorationTheme
                                            .fillColor,
                                        filled: true,
                                        hintStyle: const TextStyle(
                                            color: Color(0xffCCCCCC),
                                            fontSize: 16),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffD6D6D6),
                                                width: 0.76),
                                            borderRadius:
                                                BorderRadius.circular(6.1)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff009933),
                                                width: 0.76)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffFF0000),
                                                width: 0.76)),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffFF0000),
                                                    width: 0.76)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cooking Gas (Kg)",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge
                                                  ?.color,
                                              fontSize: 20,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "In stock",
                                              style: TextStyle(
                                                color: Color(0xff009933),
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Switch.adaptive(
                                                value: controller.isGasInStock,
                                                activeColor:
                                                    const Color(0xff009933),
                                                onChanged: (value) {
                                                  controller
                                                      .toggleIsGasInStock();
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: controller.gasPrice,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Enter price",
                                        prefixIcon: const SizedBox(
                                          height: 36,
                                          width: 14,
                                          child: Center(
                                            child: Text(
                                              "₦",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xff9C9C9C),
                                                  fontFamily: "InterSemiBold"),
                                            ),
                                          ),
                                        ),
                                        fillColor: Theme.of(context)
                                            .inputDecorationTheme
                                            .fillColor,
                                        filled: true,
                                        hintStyle: const TextStyle(
                                            color: Color(0xffCCCCCC),
                                            fontSize: 16),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffD6D6D6),
                                                width: 0.76),
                                            borderRadius:
                                                BorderRadius.circular(6.1)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff009933),
                                                width: 0.76)),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffFF0000),
                                                width: 0.76)),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffFF0000),
                                                    width: 0.76)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                                  Get.back();
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
                                            SubmitPriceConfirmation().show(
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
