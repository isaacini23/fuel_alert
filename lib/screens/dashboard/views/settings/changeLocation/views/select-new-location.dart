import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:get/get.dart';
import '../../../../../../widget/buttons/buttons.dart';

class SelectLocationView extends StatelessWidget {
  SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.color,
                              fontSize: 16,
                              fontFamily: "PoppinsSemiBold"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: List.generate(
                              controller.getStatesForCountry("Nigeria").length,
                              (index) {
                            var state = controller
                                .getStatesForCountry("Nigeria")[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: InkWell(
                                onTap: () {
                                  controller.updateSelectedStateLocation(
                                      state["name"]
                                          .toString()
                                          .split(" State")
                                          .first);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: controller
                                                  .selectedStateLocation ==
                                              state["name"]
                                                  .toString()
                                                  .split(" State")
                                                  .first
                                          ? Border.all(
                                              color: const Color(0xff009933))
                                          : null,
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    "📍  ${state["name"].toString().split("State").first}",
                                    style: TextStyle(
                                        color:
                                            controller.selectedStateLocation ==
                                                    state["name"]
                                                        .toString()
                                                        .split("State")
                                                        .first
                                                ? const Color(0xff009933)
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge
                                                    ?.color,
                                        fontSize: 14,
                                        fontFamily: "PoppinsMeds"),
                                  ),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Buttons().defaultButtons(
                    isLoading: false,
                    title: "Apply",
                    action: () {
                      controller.updateStateLocation(
                          controller.selectedStateLocation);
                    }),
              ))
        ],
      );
    });
  }
}
