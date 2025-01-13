import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widget/bottoms/navigation-bottom.dart';

class StationSkeleton extends StatelessWidget {
  const StationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return Column(
          children: List.generate(3, (index) {
        return Skeletonizer(
          enabled: true,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4.24),
                      blurRadius: 31.24,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(0.05)),
                ],
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GWT petroleum ltd".toUpperCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.color,
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "2WMH+GRQ, Oron Rd, Uyo 520102, Akwa Ibom"
                              .capitalizeFirst!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color(0xff999999),
                              fontFamily: "PoppinsMeds",
                              fontSize: 13),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: const TextSpan(
                              text: "Open ",
                              style: TextStyle(
                                  color: Color(0xff009933),
                                  fontFamily: "PoppinsMeds",
                                  fontSize: 12),
                              children: [
                                TextSpan(
                                  text: "• Closes 10pm",
                                  style: TextStyle(
                                      color: Color(0xff828282),
                                      fontFamily: "PoppinsMeds",
                                      fontSize: 12),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xff009933),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                AutoSizeText(
                                  "250M",
                                  minFontSize: 8,
                                  style: const TextStyle(
                                      color: Color(0xff999999),
                                      fontFamily: "PoppinsMeds",
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                NavigationBottom().show(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Row(
                                  children: [
                                    const AutoSizeText(
                                      minFontSize: 7,
                                      "Navigation",
                                      style: TextStyle(
                                        color: Color(0xff9599AD),
                                        fontFamily: "PoppinsMeds",
                                        fontSize: 11,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Color(0xff9C9C9C),
                            )
                          ],
                        )
                      ],
                    )),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3.53),
                            blurRadius: 25.85,
                            spreadRadius: 0,
                            color: Colors.black.withOpacity(0.10)),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        height: 22,
                        width: 94,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "5+ people in queue",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Color(0xff999999),
                            fontFamily: "PoppinsMeds",
                            fontSize: 9),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        "PETROL",
                        style: TextStyle(
                            color: Color(0XFF009933),
                            fontFamily: "PoppinsMeds",
                            fontSize: 13),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      AutoSizeText.rich(
                        minFontSize: 5,
                        TextSpan(
                            text: "₦",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                                fontFamily: "InterSemiBold",
                                fontSize: 24),
                            children: [
                              TextSpan(
                                text: "840/L",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                    fontFamily: "PoppinsSemiBold",
                                    fontSize: 24),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.42),
                                color:
                                    const Color(0xff009933).withOpacity(0.05)),
                            child: const Row(
                              children: [
                                Icon(
                                  Iconsax.star5,
                                  size: 9,
                                  color: Color(0xff009933),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                      color: Color(0xff009933), fontSize: 9),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "(20 Reviews)",
                            style: TextStyle(
                                color: Color(0xff009933), fontSize: 9),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "6 hours ago",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Color(0xff999999),
                            fontFamily: "PoppinsMeds",
                            fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }));
    });
  }
}
