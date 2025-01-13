import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';

class SubmitPumpScaleConfirmation {
  show(context, id, listItem, index, type) {
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning,
                  color: Color(0xffDE4841),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "By submitting, I agree that the pump accuracy scale submitted is accurate",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                        fontSize: 16,
                        fontFamily: "PoppinsSemiBold"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "If you submit an incorrect pump accuracy scale, you will lose all your points.",
              style: TextStyle(
                color: Color(0xff8C8C8C),
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "If you submit an incorrect pump accuracy scale, your account will be suspended",
              style: TextStyle(
                color: Color(0xff8C8C8C),
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Buttons().cancelButtons(context, title: "Cancel",
                      action: () {
                    Get.back();
                  }),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Buttons().defaultButtons(
                      isLoading: controller.isLoading,
                      title: "I agree",
                      action: () {
                        controller.submitMeterReport(
                          type: type,
                            id: id, listItem: listItem, index: index);
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      }),
    ));
  }
}
