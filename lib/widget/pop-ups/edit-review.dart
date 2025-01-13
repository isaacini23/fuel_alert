import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/widget/buttons/buttons.dart';
import 'package:fuel_alert/widget/customs/rating-bar.dart';
import 'package:get/get.dart';

class EditReviewSheet {
  show(context, id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).cardColor,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              content: GetBuilder<HomeStateController>(builder: (controller) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Edit Review",
                          style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 22,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.color),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TadeRatingBar(
                            initialRating: 0,
                            onRatingSelected: (value) {
                              controller.updateRatingText(value);
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Review",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.color,
                                    fontSize: 16,
                                    fontFamily: "PoppinsMeds"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: controller.reviewText,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                maxLength: 200,
                                validator: ValidationBuilder().build(),
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .fillColor,
                                  filled: true,
                                  hintText: "Enter review",
                                  hintStyle: const TextStyle(
                                      color: Color(0xffCCCCCC), fontSize: 16),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffD6D6D6),
                                          width: 0.76),
                                      borderRadius: BorderRadius.circular(8)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xffFF0000),
                                          width: 0.76)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
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
                              child: Buttons().defaultButtons(
                                  isLoading: controller.isLoading2,
                                  title: "Save",
                                  action: () {
                                    controller.editStationReview(id);
                                  }),
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
