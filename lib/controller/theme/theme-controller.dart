import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _darkModeKey = 'isDarkMode';
  final _systemModeKey = 'isSystemMode';

  Rx<ThemeMode> selectedTheme = ThemeMode.light.obs;

  ThemeController() {
    bool? isDarkMode = _box.read(_darkModeKey);
    bool? isSystemMode = _box.read(_systemModeKey);

    if (isSystemMode == true) {
      selectedTheme.value = ThemeMode.system;
    } else if (isDarkMode == true) {
      selectedTheme.value = ThemeMode.dark;
    } else {
      selectedTheme.value = ThemeMode.light;
    }

    _applyTheme();
  }

  void _applyTheme() {
    Get.changeThemeMode(selectedTheme.value);
  }

  void selectTheme(ThemeMode themeMode) {
    selectedTheme.value = themeMode;

    _box.write(_darkModeKey, themeMode == ThemeMode.dark);
    _box.write(_systemModeKey, themeMode == ThemeMode.system);
    _applyTheme();
  }

  void toggleDarkMode(bool isDarkMode) {
    if (isDarkMode) {
      selectTheme(ThemeMode.dark);
    } else {
      selectTheme(ThemeMode.light);
    }
  }

  void toggleSystemMode(bool isSystemMode) {
    if (isSystemMode) {
      selectTheme(ThemeMode.system);
    } else {
      selectTheme(ThemeMode.light);
    }
  }
}
