import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';

class NavigationBottom {
  show(context) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: GetBuilder<HomeStateController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 81,
                decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Choose medium of navigation",
              style: TextStyle(
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                  fontSize: 16,
                  fontFamily: "PoppinsSemiBold"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: (controller.navigationMode == "google")
                      ? Border.all(color: const Color(0xff009933))
                      : null,
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(50)),
              child: RadioListTile(
                activeColor: const Color(0xff009933),
                value: "google",
                groupValue: controller.navigationMode,
                onChanged: (value) {
                  controller.updateNavigationMode(value);
                },
                title: Row(
                  children: [
                    SvgPicture.asset("assets/images/google-maps.svg"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Google Maps",
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                          fontSize: 14,
                          fontFamily: "PoppinsMeds"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: (controller.navigationMode == "waze")
                      ? Border.all(color: const Color(0xff009933))
                      : null,
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(50)),
              child: RadioListTile(
                value: "waze",
                groupValue: controller.navigationMode,
                onChanged: (value) {
                  controller.updateNavigationMode(value);
                },
                title: Row(
                  children: [
                    SvgPicture.asset("assets/images/waze.svg"),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Waze",
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                          fontSize: 14,
                          fontFamily: "PoppinsMeds"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Buttons().defaultButtons(
                isLoading: false, title: "Navigate", action: () {}),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      }),
    ));
  }
}
