import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/core/functions/date-formatters.dart';
import 'package:fuel_alert/widget/pop-ups/edit-review.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyReviewsView extends StatelessWidget {
  MyReviewsView({super.key});

  final HomeStateController _homeStateController =
      Get.find<HomeStateController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((time) {
      _homeStateController.getUserStationReviews();
    });

    return GetBuilder<HomeStateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          automaticallyImplyLeading: false,
          shadowColor: Colors.black.withOpacity(0.15),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
              )),
          title: Text(
            "My Reviews",
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
          child: (controller.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (controller.userStationReviews.isEmpty)
                  ? const Center(
                      child: Text("No reviews"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: List.generate(
                                    controller.userStationReviews.length,
                                    (index) {
                                  var review =
                                      controller.userStationReviews[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: StarRating(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              starCount: 5,
                                              rating:
                                                  review["rating"].toDouble(),
                                              onRatingChanged: (rating) {},
                                              filledIcon: Icons.star,
                                              allowHalfRating: false,
                                              emptyIcon: Icons.star_border,
                                              size: 15,
                                              color: const Color(0xffEF934D),
                                              borderColor:
                                                  const Color(0xffEF934D),
                                            )),
                                            Row(
                                              children: [
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.color),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    EditReviewSheet().show(
                                                        context,
                                                        review["stationDetails"]
                                                            ["id"]);
                                                  },
                                                  child: Icon(
                                                    Iconsax.edit,
                                                    size: 16,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.color,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          review["stationDetails"]["name"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.color,
                                              fontFamily: "PoppinsSemiBold"),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          review["message"],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.color,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          formatDateTime(review["lastUpdated"]),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xffC3C3C3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )),
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.color,
                                    fontSize: 10.5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        ),
      );
    });
  }
}
