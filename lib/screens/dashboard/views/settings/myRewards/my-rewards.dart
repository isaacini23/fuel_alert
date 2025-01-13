import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyRewardsView extends StatelessWidget {
  const MyRewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
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
          "My Rewards",
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
                height: 10,
              ),
              ExpansionTileCard(
                expandedColor: Theme.of(context).canvasColor,
                baseColor: Theme.of(context).canvasColor,
                elevation: 0,
                title: Text(
                  "Today",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 20,
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_down),
                children: List.generate(3, (index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/reward-badge.svg"),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "You’ve won a contest",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.color,
                                  fontFamily: "PoppinsSemiBold"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  "You’ve selected as the winner of the raffle draw amongst the top contributors. ",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins",
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text(
                                    "Claim reward",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "PoppinsMeds",
                                      color: Color(0xff009933),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Yesterday • 03:43pm",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffC3C3C3),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              ExpansionTileCard(
                expandedColor: Theme.of(context).canvasColor,
                baseColor: Theme.of(context).canvasColor,
                elevation: 0,
                title: Text(
                  "Last Month",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 20,
                    color: Theme.of(context).textTheme.headlineLarge?.color,
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_down),
                children: List.generate(3, (index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/reward-badge.svg"),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "You’ve won a contest",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.color,
                                  fontFamily: "PoppinsSemiBold"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  "You’ve selected as the winner of the raffle draw amongst the top contributors. ",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins",
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.color,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text(
                                    "Claim reward",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "PoppinsMeds",
                                      color: Color(0xff009933),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Yesterday • 03:43pm",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffC3C3C3),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                color: Colors.white,
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
