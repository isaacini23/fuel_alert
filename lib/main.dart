import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuel_alert/controller/theme/theme-controller.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/core/routes/app/app-routes.dart';
import 'package:fuel_alert/core/theme/theme.dart';
import 'package:fuel_alert/services/notification/push-notification-service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApiService().initNotifications();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Obx(() {
      final ThemeController themeController = Get.put(ThemeController());
      return GetMaterialApp(
        title: 'Fuel Alert',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeController.selectedTheme.value,
        initialRoute: splashScreen,
        getPages: getPages,
      );
    });
  }
}
