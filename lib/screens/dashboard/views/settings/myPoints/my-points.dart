import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/controller/rewards/rewards-state-controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyPointsView extends StatelessWidget {
  const MyPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Iconsax.arrow_left,
            )),
        shadowColor: Colors.black.withOpacity(0.15),
        centerTitle: true,
        title: Text(
          "My Points",
          style: TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontSize: 24,
              color: Theme.of(context).textTheme.titleLarge?.color),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) {
              return [const PopupMenuItem(child: Text("Clear"))];
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).textTheme.headlineMedium?.color,
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    Text(
                      "You’ve earned",
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 17.47,
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 102,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 3.53),
                                blurRadius: 25.85,
                                color: Colors.black.withOpacity(0.10))
                          ]),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                              "assets/images/main-point-badge.svg"),
                          const SizedBox(
                            height: 5,
                          ),
                          GetBuilder<ProfileStateController>(
                              builder: (controller) {
                            return Text(
                              "${controller.user.points ?? 0}",
                              style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 24,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                              ),
                            );
                          }),
                          const Text(
                            "Points",
                            style: TextStyle(
                                fontFamily: "PoppinsMeds",
                                fontSize: 13,
                                color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Color(0xffC3C9D0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<RewardStateController>(builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xff009933)
                                              .withOpacity(0.20))),
                                  color:
                                      const Color(0xff009933).withOpacity(0.05),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: const Color(0xffEF934D)
                                              .withOpacity(0.20))),
                                  color:
                                      const Color(0xffEF934D).withOpacity(0.05),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: const Color(0xff4568F2)
                                              .withOpacity(0.20))),
                                  color:
                                      const Color(0xff4568F2).withOpacity(0.05),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: const Color(0xff8E52F4)
                                              .withOpacity(0.20))),
                                  color:
                                      const Color(0xff8E52F4).withOpacity(0.05),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
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
                            SvgPicture.asset("assets/images/raffle-draw.svg"),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: const Color(0xff960099)
                                              .withOpacity(0.20))),
                                  color:
                                      const Color(0xff960099).withOpacity(0.05),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
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
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "Version: 1.0 All rights reserved ©FuelAlert ${DateTime.now().year}",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleMedium?.color,
                        fontSize: 10.5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
