import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:get/get.dart';

import '../../../../../../widget/buttons/buttons.dart';

class ChooseLocationView extends StatelessWidget {
  ChooseLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose a location",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                        fontSize: 16,
                        fontFamily: "PoppinsSemiBold"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "🇳🇬  Nigeria",
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                          fontSize: 14,
                          fontFamily: "PoppinsMeds"),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "📍  ${controller.locationData["state"]}",
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                          fontSize: 14,
                          fontFamily: "PoppinsMeds"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Buttons().defaultButtons(
                isLoading: false,
                title: "Change",
                action: () {
                  controller.updateIsOnSelectLocationView(true);
                  controller.readJson();
                }),
            const SizedBox(
              height: 15,
            ),
            Buttons().borderButtons(context, title: "Use my location",
                action: () {
              controller.getLocation();
            }),
          ],
        ),
      );
    });
  }
}
