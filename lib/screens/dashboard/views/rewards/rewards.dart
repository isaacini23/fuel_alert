import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/controller/rewards/rewards-state-controller.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/functions/url-launcher.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RewardsView extends StatelessWidget {
  RewardsView({super.key});

  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          automaticallyImplyLeading: false,
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          title: Text(
            "Rewards",
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
          child: (controller.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Upcoming winners will be revealed in",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 17.47,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TimerCountdown(
                        format: CountDownTimerFormat.daysHoursMinutesSeconds,
                        descriptionTextStyle: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.color),
                        timeTextStyle: const TextStyle(
                            color: Color(0xff009933),
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 24.46),
                        endTime: DateTime.now().add(
                          const Duration(
                            days: 5,
                            hours: 14,
                            minutes: 27,
                            seconds: 34,
                          ),
                        ),
                        onEnd: () {
                          log("Timer finished");
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 303,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(27.95)),
                            child: Swiper(
                              itemCount: 2,
                              loop: false,
                              controller: _swiperController,
                              itemBuilder: (context, index) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "🏆",
                                    style: TextStyle(fontSize: 68),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    (index == 0)
                                        ? "Top Contributor Winners"
                                        : "Raffle Draw Winner",
                                    style: TextStyle(
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 17.47,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.color,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // (index == 0)
                                  //     ? Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceEvenly,
                                  //         children: [
                                  //           Container(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 12,
                                  //                     horizontal: 15),
                                  //             decoration: BoxDecoration(
                                  //               color: Theme.of(context)
                                  //                   .canvasColor,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(9),
                                  //               boxShadow: [
                                  //                 BoxShadow(
                                  //                     offset:
                                  //                         const Offset(0, 3.08),
                                  //                     blurRadius: 22.58,
                                  //                     spreadRadius: 0,
                                  //                     color: Colors.black
                                  //                         .withOpacity(0.10))
                                  //               ],
                                  //             ),
                                  //             child: Column(
                                  //               children: [
                                  //                 Stack(
                                  //                   children: [
                                  //                     Container(
                                  //                       height: 70,
                                  //                       width: 70,
                                  //                       decoration: BoxDecoration(
                                  //                           shape:
                                  //                               BoxShape.circle,
                                  //                           border: Border.all(
                                  //                               width: 0.87,
                                  //                               color: const Color(
                                  //                                       0xff4ADE80)
                                  //                                   .withOpacity(
                                  //                                       0.20)),
                                  //                           color: const Color(
                                  //                                   0xff4ADE80)
                                  //                               .withOpacity(
                                  //                                   0.05)),
                                  //                       child: Center(
                                  //                         child: Container(
                                  //                           height: 56,
                                  //                           width: 56,
                                  //                           decoration: const BoxDecoration(
                                  //                               shape: BoxShape
                                  //                                   .circle,
                                  //                               color: Color(
                                  //                                   0xff9C9C9C)),
                                  //                           child: const Center(
                                  //                             child: Text(
                                  //                               "EM",
                                  //                               style: TextStyle(
                                  //                                   color: Colors
                                  //                                       .white,
                                  //                                   fontFamily:
                                  //                                       "PoppinsSemiBold",
                                  //                                   fontSize:
                                  //                                       24.46),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Positioned(
                                  //                       right: 0,
                                  //                       bottom: 0,
                                  //                       child: SvgPicture.asset(
                                  //                           "assets/images/reward1.svg"),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //                 const SizedBox(
                                  //                   height: 5,
                                  //                 ),
                                  //                 const Text(
                                  //                   "Emmanuel",
                                  //                   style: TextStyle(
                                  //                       fontFamily:
                                  //                           "PoppinsSemiBold",
                                  //                       fontSize: 13,
                                  //                       color:
                                  //                           Color(0xff9599AD)),
                                  //                 ),
                                  //                 const Text(
                                  //                   "Akwa Ibom",
                                  //                   style: TextStyle(
                                  //                       fontFamily:
                                  //                           "PoppinsMeds",
                                  //                       fontSize: 9.61,
                                  //                       color:
                                  //                           Color(0xff9599AD)),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 12,
                                  //                     horizontal: 15),
                                  //             decoration: BoxDecoration(
                                  //               color: Theme.of(context)
                                  //                   .canvasColor,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(9),
                                  //               boxShadow: [
                                  //                 BoxShadow(
                                  //                     offset:
                                  //                         const Offset(0, 3.08),
                                  //                     blurRadius: 22.58,
                                  //                     spreadRadius: 0,
                                  //                     color: Colors.black
                                  //                         .withOpacity(0.10))
                                  //               ],
                                  //             ),
                                  //             child: Column(
                                  //               children: [
                                  //                 Stack(
                                  //                   children: [
                                  //                     Container(
                                  //                       height: 70,
                                  //                       width: 70,
                                  //                       decoration: BoxDecoration(
                                  //                           shape:
                                  //                               BoxShape.circle,
                                  //                           border: Border.all(
                                  //                               width: 0.87,
                                  //                               color: const Color(
                                  //                                       0xff4ADE80)
                                  //                                   .withOpacity(
                                  //                                       0.20)),
                                  //                           color: const Color(
                                  //                                   0xff4ADE80)
                                  //                               .withOpacity(
                                  //                                   0.05)),
                                  //                       child: Center(
                                  //                         child: Container(
                                  //                           height: 56,
                                  //                           width: 56,
                                  //                           decoration: const BoxDecoration(
                                  //                               shape: BoxShape
                                  //                                   .circle,
                                  //                               color: Color(
                                  //                                   0xff9C9C9C)),
                                  //                           child: const Center(
                                  //                             child: Text(
                                  //                               "SA",
                                  //                               style: TextStyle(
                                  //                                   color: Colors
                                  //                                       .white,
                                  //                                   fontFamily:
                                  //                                       "PoppinsSemiBold",
                                  //                                   fontSize:
                                  //                                       24.46),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Positioned(
                                  //                       right: 0,
                                  //                       bottom: 0,
                                  //                       child: SvgPicture.asset(
                                  //                           "assets/images/reward2.svg"),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //                 const SizedBox(
                                  //                   height: 5,
                                  //                 ),
                                  //                 const Text(
                                  //                   "Sandra",
                                  //                   style: TextStyle(
                                  //                       fontFamily:
                                  //                           "PoppinsSemiBold",
                                  //                       fontSize: 13,
                                  //                       color:
                                  //                           Color(0xff9599AD)),
                                  //                 ),
                                  //                 const Text(
                                  //                   "Akwa Ibom",
                                  //                   style: TextStyle(
                                  //                       fontFamily:
                                  //                           "PoppinsMeds",
                                  //                       fontSize: 9.61,
                                  //                       color:
                                  //                           Color(0xff9599AD)),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             padding:
                                  //                 const EdgeInsets.symmetric(
                                  //                     vertical: 12,
                                  //                     horizontal: 15),
                                  //             decoration: BoxDecoration(
                                  //               color: Theme.of(context)
                                  //                   .canvasColor,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(9),
                                  //               boxShadow: [
                                  //                 BoxShadow(
                                  //                     offset:
                                  //                         const Offset(0, 3.08),
                                  //                     blurRadius: 22.58,
                                  //                     spreadRadius: 0,
                                  //                     color: Colors.black
                                  //                         .withOpacity(0.10))
                                  //               ],
                                  //             ),
                                  //             child: Column(
                                  //               children: [
                                  //                 Stack(
                                  //                   children: [
                                  //                     Container(
                                  //                       height: 70,
                                  //                       width: 70,
                                  //                       decoration: BoxDecoration(
                                  //                           shape:
                                  //                               BoxShape.circle,
                                  //                           border: Border.all(
                                  //                               width: 0.87,
                                  //                               color: const Color(
                                  //                                       0xff4ADE80)
                                  //                                   .withOpacity(
                                  //                                       0.20)),
                                  //                           color: const Color(
                                  //                                   0xff4ADE80)
                                  //                               .withOpacity(
                                  //                                   0.05)),
                                  //                       child: Center(
                                  //                         child: Container(
                                  //                           height: 56,
                                  //                           width: 56,
                                  //                           decoration: const BoxDecoration(
                                  //                               shape: BoxShape
                                  //                                   .circle,
                                  //                               color: Color(
                                  //                                   0xff9C9C9C)),
                                  //                           child: const Center(
                                  //                             child: Text(
                                  //                               "WI",
                                  //                               style: TextStyle(
                                  //                                   color: Colors
                                  //                                       .white,
                                  //                                   fontFamily:
                                  //                                       "PoppinsSemiBold",
                                  //                                   fontSize:
                                  //                                       24.46),
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Positioned(
                                  //                       right: 0,
                                  //                       bottom: 0,
                                  //                       child: SvgPicture.asset(
                                  //                           "assets/images/reward3.svg"),
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //                 const SizedBox(
                                  //                   height: 5,
                                  //                 ),
                                  //                 const Text(
                                  //                   "Wisdom",
                                  //                   style: TextStyle(
                                  //                       fontFamily:
                                  //                           "PoppinsSemiBold",
                                  //                       fontSize: 13,
                                  //                       color:
                                  //                           Color(0xff9599AD)),
                                  //                 ),
                                  //                 const Text(
                                  //                   "Akwa Ibom",
                                  //                   style: TextStyle(
                                  //                       fontFamily:
                                  //                           "PoppinsMeds",
                                  //                       fontSize: 9.61,
                                  //                       color:
                                  //                           Color(0xff9599AD)),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : Container(
                                  //         padding: const EdgeInsets.symmetric(
                                  //             vertical: 12, horizontal: 15),
                                  //         decoration: BoxDecoration(
                                  //           color:
                                  //               Theme.of(context).canvasColor,
                                  //           borderRadius:
                                  //               BorderRadius.circular(9),
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //                 offset: const Offset(0, 3.08),
                                  //                 blurRadius: 22.58,
                                  //                 spreadRadius: 0,
                                  //                 color: Colors.black
                                  //                     .withOpacity(0.10))
                                  //           ],
                                  //         ),
                                  //         child: Column(
                                  //           children: [
                                  //             Stack(
                                  //               children: [
                                  //                 Container(
                                  //                   height: 70,
                                  //                   width: 70,
                                  //                   decoration: BoxDecoration(
                                  //                       shape: BoxShape.circle,
                                  //                       border: Border.all(
                                  //                           width: 0.87,
                                  //                           color: const Color(
                                  //                                   0xff4ADE80)
                                  //                               .withOpacity(
                                  //                                   0.20)),
                                  //                       color: const Color(
                                  //                               0xff4ADE80)
                                  //                           .withOpacity(0.05)),
                                  //                   child: Center(
                                  //                     child: Container(
                                  //                       height: 56,
                                  //                       width: 56,
                                  //                       decoration:
                                  //                           const BoxDecoration(
                                  //                               shape: BoxShape
                                  //                                   .circle,
                                  //                               color: Color(
                                  //                                   0xff9C9C9C)),
                                  //                       child: const Center(
                                  //                         child: Text(
                                  //                           "SO",
                                  //                           style: TextStyle(
                                  //                               color: Colors
                                  //                                   .white,
                                  //                               fontFamily:
                                  //                                   "PoppinsSemiBold",
                                  //                               fontSize:
                                  //                                   24.46),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 Positioned(
                                  //                   right: 0,
                                  //                   bottom: 0,
                                  //                   child: SvgPicture.asset(
                                  //                       "assets/images/reward1.svg"),
                                  //                 )
                                  //               ],
                                  //             ),
                                  //             const SizedBox(
                                  //               height: 5,
                                  //             ),
                                  //             const Text(
                                  //               "Solomon",
                                  //               style: TextStyle(
                                  //                   fontFamily:
                                  //                       "PoppinsSemiBold",
                                  //                   fontSize: 13,
                                  //                   color: Color(0xff9599AD)),
                                  //             ),
                                  //             const Text(
                                  //               "Akwa Ibom",
                                  //               style: TextStyle(
                                  //                   fontFamily: "PoppinsMeds",
                                  //                   fontSize: 9.61,
                                  //                   color: Color(0xff9599AD)),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _swiperController.previous();
                                    },
                                    child: const Icon(
                                      Iconsax.arrow_left_2,
                                      color: Color(0xff009933),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _swiperController.next();
                                    },
                                    child: const Icon(
                                      Iconsax.arrow_right_3,
                                      color: Color(0xff009933),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 53,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(topContributorsScreen);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: const Center(
                                child: Text(
                                  "View Top Contributors",
                                  style: TextStyle(
                                      color: Color(0xff009933),
                                      fontSize: 18,
                                      fontFamily: "PoppinsMeds"),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffD6D6D6),
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
                        width: 200,
                        height: 200,
                        selectedStepSize: 15,
                        child: GetBuilder<ProfileStateController>(
                            builder: (profileController) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${profileController.user.points  ?? 0}",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.color,
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 35.85),
                              ),
                              const Text(
                                "points",
                                style: TextStyle(
                                    color: Color(0xff828282),
                                    fontFamily: "PoppinsMeds",
                                    fontSize: 15.42),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   "You still have a chance to win a prize",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontFamily: "PoppinsSemiBold",
                      //     fontSize: 16,
                      //     color:
                      //         Theme.of(context).textTheme.headlineLarge?.color,
                      //   ),
                      // ),
                      // const Text(
                      //   "You can redeem points to join the raffle draw",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontFamily: "PoppinsMeds",
                      //       fontSize: 13,
                      //       color: Color(0xff999999)),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Buttons().cancelButtons(context,
                      //             title: "Leave draw", action: () {}),
                      //       ),
                      //       const SizedBox(
                      //         width: 15,
                      //       ),
                      //       Expanded(
                      //         child: Buttons().defaultButtons(
                      //             isLoading: false,
                      //             title: "Enter draw",
                      //             action: () {}),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffD6D6D6),
                      ),
                      GetBuilder<ThemeController>(builder: (themeController) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          color: Theme.of(context).unselectedWidgetColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Missions",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.color,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text:
                                        "Take part in our weekly missions and stand a chance to win! ",
                                    style: const TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 13,
                                        color: Color(0xff999999)),
                                    children: [
                                      WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(rulesScreen);
                                            },
                                            child: const Text("Learn more",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: "PoppinsMeds",
                                                    color: Color(0xff009933))),
                                          ))
                                    ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(30),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/submit-fuel-price.svg"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Submit Fuel Price",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.color,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Enter the daily prices for gas station products and earn points.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontFamily: "PoppinsMeds"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color(0xff009933)
                                                          .withOpacity(0.20))),
                                              color: const Color(0xff009933)
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40))),
                                          child: Center(
                                            child: Text(
                                              "Earn ${controller.pointConfig.petrol} points",
                                              style: const TextStyle(
                                                  color: Color(0xff009933),
                                                  fontFamily: "PoppinsMeds",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(30),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/submit-pump-scale.svg"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Submit Pump Scale",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.color,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Submit pump accuracy scale to aid others in making informed decisions.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontFamily: "PoppinsMeds"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: const Color(
                                                              0xffEF934D)
                                                          .withOpacity(0.20))),
                                              color: const Color(
                                                      0xffEF934D)
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40))),
                                          child: Center(
                                            child: Text(
                                              "Earn ${controller.pointConfig.meterReport} points",
                                              style: const TextStyle(
                                                  color: Color(0xffEF934D),
                                                  fontFamily: "PoppinsMeds",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(30),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/submit-queue-report.svg"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Submit Queue Report",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.color,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Submit queue length at stations to assist others in making informed decisions.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontFamily: "PoppinsMeds"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: const Color(
                                                              0xff4568F2)
                                                          .withOpacity(0.20))),
                                              color: const Color(
                                                      0xff4568F2)
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40))),
                                          child: Center(
                                            child: Text(
                                              "Earn ${controller.pointConfig.queueReport} points",
                                              style: const TextStyle(
                                                  color: Color(0xff4568F2),
                                                  fontFamily: "PoppinsMeds",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(30),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/submit-reviews.svg"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Submit Reviews",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.color,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Leave reviews of your experiences at gas stations",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontFamily: "PoppinsMeds"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: const Color(
                                                              0xff8E52F4)
                                                          .withOpacity(0.20))),
                                              color: const Color(
                                                      0xff8E52F4)
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40))),
                                          child: const Center(
                                            child: Text(
                                              "Earn 10 points",
                                              style: TextStyle(
                                                  color: Color(0xff8E52F4),
                                                  fontFamily: "PoppinsMeds",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(30),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/raffle-draw.svg"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Raffle Draw Ticket",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium
                                                  ?.color,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Participate in a raffle draw by purchasing raffle draw ticket with points and earn more",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontFamily: "PoppinsMeds"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: const Color(
                                                              0xff960099)
                                                          .withOpacity(0.20))),
                                              color: const Color(
                                                      0xff960099)
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40))),
                                          child: const Center(
                                            child: Text(
                                              "Earn 3 points",
                                              style: TextStyle(
                                                  color: Color(0xff960099),
                                                  fontFamily: "PoppinsMeds",
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Feel free to reach out",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "PoppinsMeds",
                            fontSize: 18,
                            color: Color(0xff828282)),
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
                                launchUrls(
                                    "https://docs.google.com/forms/d/e/1FAIpQLSdrTpOcGkn3cIZodQ7eRRH9RdgpR_jQWVwjd4kVAFUrM8XIrg/viewform");
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
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
        ),
      );
    });
  }
}
