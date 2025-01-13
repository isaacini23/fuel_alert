import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<void> storeLocationPreference(bool enabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('locationEnabled', enabled);
  }

  Future<bool?> fetchLocationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('locationEnabled');
  }
}