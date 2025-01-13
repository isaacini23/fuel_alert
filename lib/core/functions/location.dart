  // LOCATION SERVICE
  import 'dart:convert';
import 'dart:developer';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    log('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

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

  }



