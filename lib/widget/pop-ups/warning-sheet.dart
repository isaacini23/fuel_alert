import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:get/get.dart';

class WarningSheet {
  show(context, {title, subtitle, action}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              content:
                  GetBuilder<ProfileStateController>(builder: (controller) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 22,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.color),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "PoppinsMeds",
                              fontSize: 14.28,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.color),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
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
                              child: Buttons().dangerButtons(
                                  isLoading: controller.isLoading,
                                  title: "Yes, delete",
                                  action: action),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            ));
  }
}
