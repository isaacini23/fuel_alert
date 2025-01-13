import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/changeLocation/views/choose-location-view.dart';
import 'package:fuel_alert/screens/dashboard/views/settings/changeLocation/views/select-new-location.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ChangeLocationScreen extends StatelessWidget {
  ChangeLocationScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return GetBuilder<HomeStateController>(builder: (controller) {
      return LoadingOverlay(
        isLoading: controller.isLoading,
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            leading: IconButton(
                onPressed: () {
                  controller.isOnSelectLocationView
                      ? controller.updateIsOnSelectLocationView(false)
                      : Get.back();
                },
                icon: const Icon(
                  Iconsax.arrow_left,
                )
              ),
            shadowColor: Colors.black.withOpacity(0.15),
            centerTitle: true,
            title: Text(
              "Change Location",
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: (controller.isOnSelectLocationView)
                ? SelectLocationView()
                : ChooseLocationView(),
          ),
        ),
      );
    });
  }
}
