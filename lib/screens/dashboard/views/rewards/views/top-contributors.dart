import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/rewards/rewards-state-controller.dart';
import 'package:get/get.dart';

class TopContributorsScreen extends StatelessWidget {
  TopContributorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          title: Text(
            "Top 30 contributors",
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
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
              child: Column(
            children: List.generate(
                controller.leadershipBoard.length,
                (index) => Column(
                      children: [
                        ListTile(
                          leading: Text(
                            "${index + 1}",
                            style: const TextStyle(
                                fontFamily: "PoppinsSemiBold",
                                fontSize: 16,
                                color: Color(0xff9599AD)),
                          ),
                          trailing: const Text(
                            "20000 points",
                            style: TextStyle(
                                color: Color(0xff009933),
                                fontSize: 14,
                                fontFamily: "PoppinsMeds"),
                          ),
                          title: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 0.87,
                                            color: const Color(0xff4ADE80)
                                                .withOpacity(0.20)),
                                        color: const Color(0xff4ADE80)
                                            .withOpacity(0.05)),
                                    child: Center(
                                      child: Container(
                                        height: 56,
                                        width: 56,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff9C9C9C)),
                                        child: Center(
                                          child: Text(
                                            (index == 0)
                                                ? "EM"
                                                : (index == 1)
                                                    ? "SA"
                                                    : (index == 2)
                                                        ? "WI"
                                                        : "GL",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "PoppinsSemiBold",
                                                fontSize: 24.46),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  (index > 2)
                                      ? const SizedBox()
                                      : Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: SvgPicture.asset(
                                              "assets/images/reward${index + 1}.svg"),
                                        )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (index == 0)
                                        ? "Emmanuel"
                                        : (index == 1)
                                            ? "Sandra"
                                            : (index == 2)
                                                ? "Wisdom"
                                                : "Glory",
                                    style: const TextStyle(
                                        fontFamily: "PoppinsSemiBold",
                                        fontSize: 16,
                                        color: Color(0xff9599AD)),
                                  ),
                                  const Text(
                                    "Akwa Ibom",
                                    style: TextStyle(
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 9.61,
                                        color: Color(0xff9599AD)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xffD6D6D6),
                        )
                      ],
                    )),
          )),
        ),
      );
    });
  }
}
