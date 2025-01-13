import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/models/station-model.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/station-map-view.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:fuel_alert/widget/customs/rating-bar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RatingReviewScreen extends StatelessWidget {
  RatingReviewScreen({super.key});

  Station station = Get.arguments["station"];
  int index = Get.arguments["index"];
  List<dynamic> listItem = Get.arguments["listItem"];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProfileStateController profileStateController =
      Get.find<ProfileStateController>();
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
            child: Form(
              key: _formKey,
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
                                          color: listItem[index]
                                                      ["stationDetails"]
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
                                //                         color:
                                //                             Color(0xff009933),
                                //                         fontFamily:
                                //                             "PoppinsMeds",
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
                                //                         fontFamily:
                                //                             "PoppinsMeds",
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
                                //                         fontFamily:
                                //                             "PoppinsMeds",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "How would you rate Adhere?",
                                  style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TadeRatingBar(
                                    initialRating: 0,
                                    onRatingSelected: (value) {
                                      controller.updateRatingText(value);
                                    }),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Ratings is required",
                                  style: TextStyle(
                                    color: Color(0xffDE4841),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Leave a comment",
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        fontSize: 16,
                                        fontFamily: "PoppinsSemiBold"),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  const Text(
                                    "Your reviews would help us provide you with improved services",
                                    style: TextStyle(
                                        color: Color(0xffC3C9D0),
                                        fontSize: 12,
                                        fontFamily: "PoppinsMeds"),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    maxLength: 1000,
                                    minLines: 3,
                                    maxLines: 100,
                                    controller: controller.reviewText,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .inputDecorationTheme
                                          .fillColor,
                                      filled: true,
                                      hintText: "Write here",
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
                          ),
                          const SizedBox(
                            height: 20,
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
                                      isLoading: controller.isLoading,
                                      title: "Submit",
                                      action: () {
                                        if (controller.ratingText == 0 ||
                                            controller
                                                .reviewText.text.isEmpty) {
                                          Get.snackbar("Error",
                                              "Please complete the required fields to continue",
                                              colorText: Colors.white,
                                              backgroundColor: Colors.red);
                                        } else {
                                          _formKey.currentState!.validate()
                                              ? controller.rateStation(
                                                  id: station
                                                      .stationDetails!.id,
                                                  listItem: listItem,
                                                  index: index)
                                              : AutovalidateMode.disabled;
                                        }
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
            ),
          ));
    });
  }
}
