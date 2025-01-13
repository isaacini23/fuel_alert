import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentStep = 0;


Future<void> getLocation(BuildContext context, Function(int) updateProgress) async {
  try {
    String? storedLocationData = await LocalStorage().fetchLocationData();
    if (storedLocationData != null) {
      Map<String, dynamic> locationData = jsonDecode(storedLocationData);
      if (locationData['longitude'] != null &&
          locationData['latitude'] != null &&
          locationData['country'] != null &&
          locationData['state'] != null &&
          locationData['address'] != null) {
        String authToken = await LocalStorage().fetchUserToken();
        (authToken.isEmpty)
            ? Get.toNamed(onboardingScreen)
            : Get.toNamed(dashboard);
        return;
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Location Services Disabled"),
          content: const Text("To use location-based features, please enable location services in your device settings."),
          actions: [
            TextButton(
              onPressed: () async{
                 Navigator.pop(context);
                String authToken = await LocalStorage().fetchUserToken();
                (authToken.isEmpty)
                    ? Get.toNamed(onboardingScreen)
                    : Get.toNamed(dashboard);
              },
              child: const Text("Proceed Without Location"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openLocationSettings();
                getLocation(context, updateProgress);
              },
              child: const Text("Open Location Settings"),
            ),
          ],
        ),
      );
      return;
    }

    updateProgress(20);

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Location Access Denied"),
          content: const Text("Location access is permanently denied. Please enable it in the app settings."),
          actions: [
            TextButton(
              onPressed: () async{
                 Navigator.pop(context);
                String authToken = await LocalStorage().fetchUserToken();
                (authToken.isEmpty)
                    ? Get.toNamed(onboardingScreen)
                    : Get.toNamed(dashboard);
              },
              child: const Text("Proceed Without Location"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings();
              },
              child: const Text("Open App Settings"),
            ),
          ],
        ),
      );
      return;
    }

    if (permission == LocationPermission.denied) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Location Access Denied"),
          content: const Text("Location access is needed for personalized features."),
          actions: [
            TextButton(
              onPressed:() async{
                 Navigator.pop(context);
                String authToken = await LocalStorage().fetchUserToken();
                (authToken.isEmpty)
                    ? Get.toNamed(onboardingScreen)
                    : Get.toNamed(dashboard);
              },
              child: const Text("Proceed Without Location"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                getLocation(context, updateProgress);
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
      return;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      updateProgress(60);

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      log('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      updateProgress(80);

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      String country = placemarks.first.country ?? '';
      String state = placemarks.first.administrativeArea ?? '';
      String address = placemarks.first.street ?? '';

      Map<String, dynamic> locationData = {
        "longitude": position.longitude,
        "latitude": position.latitude,
        "country": country,
        "state": state,
        "address": address,
      };
      log(locationData.toString());

      String encodedData = jsonEncode(locationData);
      await LocalStorage().storeLocationData(encodedData);

      updateProgress(100);
    }

    String authToken = await LocalStorage().fetchUserToken();
    (authToken.isEmpty)
        ? Get.toNamed(onboardingScreen)
        : Get.toNamed(dashboard);
  } catch (e) {
    log("Exception: $e");
    String authToken = await LocalStorage().fetchUserToken();
    (authToken.isEmpty)
        ? Get.toNamed(onboardingScreen)
        : Get.toNamed(dashboard);
  }
}

  void fetchLocation() {
    getLocation(context, (progress) {
      setState(() {
        _currentStep = progress;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      fetchLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GetBuilder<ThemeController>(
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
              controller.selectedTheme.value == ThemeMode.light
      ? "assets/images/FuelAlert Logo.svg"
      : controller.selectedTheme.value == ThemeMode.dark
          ? "assets/images/light-logo.svg"
          : brightness == Brightness.dark
              ? "assets/images/light-logo.svg"
              : "assets/images/FuelAlert Logo.svg",
                  height: 105.38,
                  width: 281,
                ),
                Visibility(
                  visible: _currentStep > 20,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: StepProgressIndicator(
                          totalSteps: 100,
                          currentStep: _currentStep,
                          size: 8,
                          padding: 0,
                          selectedColor: const Color(0xff009933),
                          unselectedColor: const Color(0xffF0F2F5),
                          roundedEdges: const Radius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
