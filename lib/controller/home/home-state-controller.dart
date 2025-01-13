import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuel_alert/controller/profile/profile-state-controller.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/core/local-storage/preferences.dart';
import 'package:fuel_alert/models/price-reference-model.dart';
import 'package:fuel_alert/models/station-model.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/services/notification/notification-api-services.dart';
import 'package:fuel_alert/services/station/station-services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/reviews-model.dart';

class HomeStateController extends GetxController {
  bool _isSearchActive = false;
  final TextEditingController _searchText = TextEditingController();
  final TextEditingController _favoriteSearchText = TextEditingController();
  List<dynamic> _stationTypes = [];
  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _isFetchingMore = false;
  bool _isMapVisible = false;
  bool _isFavMapView = false;
  List<dynamic> _petrolStations = [];
  List<dynamic> _dieselStations = [];
  List<dynamic> _gasStations = [];
  List<dynamic> _keroseneStations = [];
  List<dynamic> _allStations = [];
  List<dynamic> _mapViewStations = [];
  final List<dynamic> _pumpAccuracyCategory = [
    "Excellent",
    "Good",
    "Fair",
    "Poor",
  ];
  final List<dynamic> _queueReportCategory = [
    "NoQueue",
    "OneToTen",
    "TenToTwenty",
    "TwentyToFifty",
    "MoreThanFifty",
  ];
  final List<dynamic> _timeFilterValues =[
    "OneToThirtyMin",
    "ThirtyToTwoHrs",
    "TwoHrsToTwentyFourHrs",
    "OneDayTo7Days",
    "SevenDaysAndAbove"
  ];
  String _selectedTimeFilterValue = "";
  String _selectedPumpAccuracy = "";
  String _selectedQueueReport = "";
  String _petrolToken = "";
  String _gasToken = "";
  String _dieselToken = "";
  String _keroseneToken = "";
  Station _station = Station();
  bool _isPetrolInStock = false;
  bool _isGasInStock = false;
  bool _isKeroseneInStock = false;
  bool _isDieselInStock = false;
  final TextEditingController _fuelPrice = TextEditingController();
  final TextEditingController _gasPrice = TextEditingController();
  final TextEditingController _kerosenePrice = TextEditingController();
  final TextEditingController _dieselPrice = TextEditingController();
  int _currentStationIndex = 0;
  String _navigationMode = "google";
  final TextEditingController _reviewText = TextEditingController();
  num _ratingText = 0;
  List<dynamic> _stationReviews = [];
  bool _isOnSelectLocationView = false;
  List<dynamic> _countries = [];
  Map<String, dynamic> _locationData = {};
  String _selectedStateLocation = "";
  List<dynamic> _allFavouriteStations = [];
  List<dynamic> _favpetrolStations = [];
  List<dynamic> _favdieselStations = [];
  List<dynamic> _favgasStations = [];
  List<dynamic> _favkeroseneStations = [];
  List<dynamic> _allSearchStations = [];
  List<dynamic> _searchPetrolStations = [];
  List<dynamic> _searchDieselStations = [];
  List<dynamic> _searchGasStations = [];
  List<dynamic> _searchKeroseneStations = [];
  List<dynamic> _recentSearchList = [];
  List<dynamic> _rewardLeaderBoard = [];
  StationReviews? _stationReviewsModel = StationReviews();
  PriceReference _priceReference = PriceReference();
  List<dynamic> _userStationReviews = [];
  List<dynamic> _userNotificationList = [];
  final Map<String, bool> _productFilter = {
    "petrol": false,
    "diesel": false,
    "gas": false,
    "kerosene": false,
  };
  bool? _showOnlyOpenStations = false;
  final List<String> _ratingFilter = ["5", "4", "3", "2", "1"];
  String? _selectedRatingFilter = "";
  final List<String> _distanceFilter = [
    "0 - 100",
    "10 - 1000",
    "1000 - 5000",
    "5000 - 10000",
    "10000"
  ];
  String? _selectedDistanceFilter = "";
  num? _minDistance;
  num? _maxDistance;
  final List<String> _priceFilter = [
    "0 - 800",
    "800 - 900",
    "900 - 1000",
    "1000 - 2000",
    "2000",
  ];
  String? _selectedPriceFilter = "";
  num? _minPrice;
  num? _maxPrice;
  bool _pushNotificationActive = false;
  String _selectedMapViewType = "";
  bool _isLocationEnabled = false;
    final List<MapType> _mapTypes = [
    MapType.normal,
    MapType.hybrid,
    MapType.satellite,
    MapType.terrain,
  ];
  int _selectedMapType = 0;
  int _unreadCount = 0;


  bool get isSearchActive => _isSearchActive;
  bool get isLocationEnabled => _isLocationEnabled;
  TextEditingController get searchText => _searchText;
  TextEditingController get favoriteSearchText => _favoriteSearchText;
  List<dynamic> get stationTypes => _stationTypes;
  bool get isLoading => _isLoading;
  bool get isLoading2 => _isLoading2;
  bool get isFetchingMore => _isFetchingMore;
  bool get isMapVisible => _isMapVisible;
  bool get isFavMapView => _isFavMapView;
  List<dynamic> get recentSearchList => _recentSearchList;
  List<dynamic> get petrolStations => _petrolStations;
  List<dynamic> get dieselStations => _dieselStations;
  List<dynamic> get gasStations => _gasStations;
  List<dynamic> get keroseneStations => _keroseneStations;
  List<dynamic> get allStations => _allStations;
  List<dynamic> get pumpAccuracyCategory => _pumpAccuracyCategory;
  List<dynamic> get queueReportCategory => _queueReportCategory;
  String get petrolToken => _petrolToken;
  String get gasToken => _gasToken;
  String get dieselToken => _dieselToken;
  String get keroseneToke => _keroseneToken;
  Station get station => _station;
  bool get isPetrolInStock => _isPetrolInStock;
  bool get isGasInStock => _isGasInStock;
  bool get isKeroseneInStock => _isKeroseneInStock;
  bool get isDieselInStock => _isDieselInStock;
  TextEditingController get fuelPrice => _fuelPrice;
  TextEditingController get gasPrice => _gasPrice;
  TextEditingController get kerosenePrice => _kerosenePrice;
  TextEditingController get dieselPrice => _dieselPrice;
  String get selectedPumpAccuracy => _selectedPumpAccuracy;
  String get selectedQueueReport => _selectedQueueReport;
  int get currentStationIndex => _currentStationIndex;
  List<dynamic> get mapViewStations => _mapViewStations;
  String get navigationMode => _navigationMode;
  TextEditingController get reviewText => _reviewText;
  num get ratingText => _ratingText;
  List<dynamic> get stationReviews => _stationReviews;
  bool get isOnSelectLocationView => _isOnSelectLocationView;
  List<dynamic> get countries => _countries;
  Map<String, dynamic> get locationData => _locationData;
  String get selectedStateLocation => _selectedStateLocation;
  List<dynamic> get allFavouriteStations => _allFavouriteStations;
  List<dynamic> get favPetrolStations => _favpetrolStations;
  List<dynamic> get favDieselStations => _favdieselStations;
  List<dynamic> get favGasStations => _favgasStations;
  List<dynamic> get favKeroseneStations => _favkeroseneStations;
  List<dynamic> get allSearchStations => _allSearchStations;
  List<dynamic> get searchPetrolStations => _searchPetrolStations;
  List<dynamic> get searchDieselStations => _searchDieselStations;
  List<dynamic> get searchGasStations => _searchGasStations;
  List<dynamic> get searchKeroseneStations => _searchKeroseneStations;
  StationReviews? get stationReviewsModel => _stationReviewsModel;
  List<dynamic> get rewardLeaderBoard => _rewardLeaderBoard;
  PriceReference get priceReference => _priceReference;
  List<dynamic> get userStationReviews => _userStationReviews;
  List<dynamic> get userNotificationList => _userNotificationList;
  List<String> get priceFilter => _priceFilter;
  List<String> get ratingFilter => _ratingFilter;
  List<String> get distanceFilter => _distanceFilter;
  Map<String, bool> get productFilter => _productFilter;
  bool? get showOnlyOpenStations => _showOnlyOpenStations;
  String? get selectedRatingFilter => _selectedRatingFilter;
  String? get selectedDistanceFilter => _selectedDistanceFilter;
  num? get minDistance => _minDistance;
  num? get maxDistance => _maxDistance;
  String? get selectedPriceFilter => _selectedPriceFilter;
  num? get minPrice => _minPrice;
  num? get maxPrice => _maxPrice;
  bool get pushNotificationActive => _pushNotificationActive;
  String get selectedMapViewType => _selectedMapViewType;
  int get selectedMapType => _selectedMapType;
  List<MapType> get mapTypes => _mapTypes;
  List<dynamic> get timeFilterValues => _timeFilterValues;
  String get selectedTimeFilterValue=> _selectedTimeFilterValue;
  int get unreadCount => _unreadCount;


  // LOCATION SERVICE
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    updateIsLoading(true);

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

    updateIsLoading(false);

    Get.offAllNamed(dashboard);
  }

  updateCurrentLocation() async {
    String encodedData = await LocalStorage().fetchLocationData();
    _locationData = jsonDecode(encodedData);
    update();
  }

  launchUrls(String url) async {
    (await canLaunchUrl(Uri.parse(url)))
        ? launchUrl(Uri.parse(url))
        : log("Cannot launch url");
  }

  updateStateLocation(value) async {
    String encodedData = await LocalStorage().fetchLocationData();
    _locationData = jsonDecode(encodedData);
    _locationData["state"] = value;
    String encodedData2 = jsonEncode(_locationData);
    log(locationData.toString());
    await LocalStorage().storeLocationData(encodedData2);
    Get.offAllNamed(dashboard);
    update();
  }

  // ========== JSON ===========
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/countries.json');
    final data = await json.decode(response);
    updateCountriesData(data);
  }

  List<dynamic> getStatesForCountry(String countryName) {
    var country = _countries.firstWhere(
      (country) => country['name'] == countryName,
      orElse: () => null,
    );

    if (country != null) {
      return country['states'];
    } else {
      return [];
    }
  }

  launchGoogleMaps({longitude, latitude}) async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
    ;
    (await canLaunchUrl(Uri.parse(url)))
        ? launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)
        : Get.snackbar("Error", "Cannot launch url",
            colorText: Colors.white, backgroundColor: Colors.red);
  }

  // PREFERENCES
  Future<void> loadLocationPreference() async {
    bool enabled = await Preferences().fetchLocationPreference() ?? false;
    _isLocationEnabled = enabled;

    update();
  }

  Future<void> onToggleLocation(bool value) async {
    if (value) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        await Preferences().storeLocationPreference(true);
        _isLocationEnabled = true;
        Get.snackbar("Location Enabled", "Location services have been enabled.",
        colorText: Colors.white,
        backgroundColor: Colors.green
        );
      loadLocationPreference();
      getAllStations();
      } else {
        await Geolocator.openAppSettings();
        Get.snackbar(
          "Permission Denied",
          "Enable location access from device settings.",
          colorText: Colors.white,
          backgroundColor: Colors.red
        );
        _isLocationEnabled = false;
      loadLocationPreference();
      }
    } else {
      await Preferences().storeLocationPreference(false);
      _isLocationEnabled = false;
      Get.snackbar(
        "Location Disabled",
        "Location services have been disabled.",
        colorText: Colors.white,
        backgroundColor: Colors.green
      );
      loadLocationPreference();

    }
  }

  // SETTERS
  updateSelectedMapType(v){
    _selectedMapType = v;
    update();
  }

  updateUnreadCount(v){
    _unreadCount = v;
    update();
  }

  updateSelectedMapViewType(value) {
    _selectedMapViewType = value;
    update();
  }

  toggleIsPetrolInStock() {
    _isPetrolInStock = !_isPetrolInStock;
    update();
  }

  updateIsPetrolInStock(value) {
    _isPetrolInStock = value;
    update();
  }

  updateIsKeroseneInStock(value) {
    _isKeroseneInStock = value;
    update();
  }

  updateIsDieselInStock(value) {
    _isDieselInStock = value;
    update();
  }

  updateIsGasInStock(value) {
    _isGasInStock = value;
    update();
  }

  updateCountriesData(value) {
    _countries = value;
    update();
  }

  updateIsOnSelectLocationView(value) {
    _isOnSelectLocationView = value;
    update();
  }

  updateCurrentStationIndex(value) {
    _currentStationIndex = value;
    update();
  }

  togglePushNotification() {
    _pushNotificationActive = !_pushNotificationActive;
    update();
  }

  toggleIsGasInStock() {
    _isGasInStock = !_isGasInStock;
    update();
  }

  updateMapViewStations(value) {
    _mapViewStations = value;
    update();
  }

  toggleIsKeroseneInStock() {
    _isKeroseneInStock = !_isKeroseneInStock;
    update();
  }

  toggleIsDieselInStock() {
    _isDieselInStock = !_isDieselInStock;
    update();
  }

  updateIsLoading(value) {
    _isLoading = value;
    update();
  }

  updateIsLoading2(value) {
    _isLoading2 = value;
    update();
  }

  updateIsFetchingMore(value) {
    _isFetchingMore = value;
    update();
  }

  updateIsSearchActive() {
    _isSearchActive = !_isSearchActive;
    _searchText.clear();
    update();
  }

  updateIsSearchActiveFalse() {
    _isSearchActive = false;
    update();
  }

  updateStationTypes(value) {
    _stationTypes = value;
    update();
  }

  updatePetrolStation(value) {
    _petrolStations = value;
    update();
  }

  updateDieselStation(value) {
    _dieselStations = value;
    update();
  }

  updateStationModel(value) {
    _station = Station.fromMap(value);
    update();
  }

  updateGasStation(value) {
    _gasStations = value;
    update();
  }

  updateKeroseneStation(value) {
    _keroseneStations = value;
    update();
  }

  updateAllStations(List<dynamic> stations) {
    final uniqueStations = {
      for (var station in stations) station["stationDetails"]['name']: station
    }.values.toList();
    _allStations = uniqueStations;
    update();
  }

  toggleIsMapVisible() {
    _isMapVisible = !_isMapVisible;
    update();
  }

  toggleIsfavMapViewVisible() {
    _isFavMapView = !_isFavMapView;
    update();
  }

  updateSelectedPumpAccuracy(value) {
    _selectedPumpAccuracy = value;
    update();
  }

  updateSelectedTimeFilterValue(value) {
    _selectedTimeFilterValue = value;
    update();
  }

  updateSelectedQueueReport(value) {
    _selectedQueueReport = value;
    update();
  }

  updateNavigationMode(value) {
    _navigationMode = value;
    update();
  }

  updateRatingText(value) {
    _ratingText = value;
    update();
  }

  updateStationReviews(value) {
    _stationReviews = value;
    update();
  }

  updateSearchText(value) {
    _searchText.text = value;
    update();
  }

  clearSearchLists() {
    _allSearchStations.clear();
    _searchDieselStations.clear();
    _searchGasStations.clear();
    _searchKeroseneStations.clear();
    _searchPetrolStations.clear();
    update();
  }

  updateAllFavouriteStations(value) {
    _allFavouriteStations = value;
    update();
  }

  updateSelectedStateLocation(value) {
    _selectedStateLocation = value;
    update();
  }

  updateRecentSearchList(value) {
    _recentSearchList = value;
    update();
  }

  updateRewardLeaderBoard(value) {
    _rewardLeaderBoard = value;
    update();
  }

  toggleStationFilter() {
    _showOnlyOpenStations = !_showOnlyOpenStations!;
    update();
  }

  updateProductFilter({key, newValue}) {
    _productFilter[key] = newValue;
    update();
  }

  updateRatingFilter(value) {
    _selectedRatingFilter = value;
    update();
  }

  updateDistanceFilter(value) {
    _selectedDistanceFilter = value;
    update();
  }

  updateMinDistance(String value) {
    _minDistance = double.parse(value);
    update();
  }

  updateMaxDistance(String value) {
    _maxDistance = double.parse(value);
    update();
  }

  clearDistance() {
    _maxDistance = null;
    _minDistance = null;
    update();
  }

  clearPrice() {
    _maxPrice = null;
    _minPrice = null;
    update();
  }

  updatePriceFilter(value) {
    _selectedPriceFilter = value;
    update();
  }

  updateMinPrice(String value) {
    _minPrice = int.parse(value);
    update();
  }

  updateMaxPrice(String value) {
    _maxPrice = int.parse(value);
    update();
  }

  toggleSelectedFavoriteList(
      {required int index, required List<dynamic> listItem}) {
    if (listItem[index]["stationDetails"]["isFavorite"]) {
      listItem[index]["stationDetails"]["isFavorite"] =
          !listItem[index]["stationDetails"]["isFavorite"];
      removeFromFavourites(id: listItem[index]["stationDetails"]["id"]);
    } else {
      listItem[index]["stationDetails"]["isFavorite"] =
          !listItem[index]["stationDetails"]["isFavorite"];
      addToFavourites(id: listItem[index]["stationDetails"]["id"]);
    }
    update();
  }

  toggleFavoriteStationList(
      {required int index, required List<dynamic> listItem}) {
    if (listItem[index]["stationDetails"]["isFavorite"]) {
      listItem[index]["stationDetails"]["isFavorite"] =
          !listItem[index]["stationDetails"]["isFavorite"];
      listItem.removeAt(index);
      removeFromFavourites(id: listItem[index]["stationDetails"]["id"]);
    } else {
      listItem[index]["stationDetails"]["isFavorite"] =
          !listItem[index]["stationDetails"]["isFavorite"];
    }
    update();
  }

  updateUserStationReviews(value) {
    _userStationReviews = value;
    update();
  }

  updateUserNotification(value) {
    _userNotificationList = value;
    update();
  }

  resetFilters() {
    _productFilter["petrol"] = false;
    _productFilter["diesel"] = false;
    _productFilter["gas"] = false;
    _productFilter["kerosene"] = false;
    _showOnlyOpenStations = false;
    _selectedPumpAccuracy = "";
    _selectedRatingFilter = "";
    _selectedPriceFilter = "";
    _minDistance = null;
    _maxDistance = null;
    _minPrice = null;
    _maxPrice = null;
    _selectedDistanceFilter = "";
    update();
  }

  // LOCAL STORAGE
  Future getRecentSearchList() async {
    String encodedData = await LocalStorage().fetchRecentSearchList();
    if (encodedData.isEmpty) {
      null;
    } else {
      List<dynamic> decodedData = jsonDecode(encodedData);
      updateRecentSearchList(decodedData);
    }
    update();
  }

  Future addToRecentSearchList(value) async {
    _recentSearchList.insert(0, value);
    String encodedData = jsonEncode(_recentSearchList);
    await LocalStorage().storeRecentSearchList(encodedData);
    update();
  }

  Future removeFromRecentSearchList(value) async {
    _recentSearchList.remove(value);
    String encodedData = jsonEncode(_recentSearchList);
    await LocalStorage().storeRecentSearchList(encodedData);
    update();
  }

  String formatDistance(num distanceInMeters) {
    if (distanceInMeters >= 1000) {
      num distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(2)}KM';
    } else {
      return '${distanceInMeters.toStringAsFixed(0)}M';
    }
  }

  num convertRangeToMiddle(String range) {
    switch (range) {
      case "OneToTen":
        return (1 + 10) ~/ 2; // (1 + 10) / 2 = 5
      case "TenToTwenty":
        return (10 + 20) ~/ 2; // (10 + 20) / 2 = 15
      case "TwentyToFifty":
        return (20 + 50) ~/ 2; // (20 + 50) / 2 = 35
      case "MoreThanFifty":
        return 50; // Assuming 50 since there's no upper limit, so we choose 50.
      default:
        return 0;
    }
  }

  Map<String, List<Map<String, dynamic>>> groupNotificationsByDate(
      List<Map<String, dynamic>> notifications) {
        
    Map<String, List<Map<String, dynamic>>> groupedNotifications = {};

    for (var notification in notifications) {
      DateTime dateTime = DateTime.parse(notification["createdAt"]);
      DateTime now = DateTime.now();

      String dateLabel;
      if (DateFormat('yyyy-MM-dd').format(dateTime) ==
          DateFormat('yyyy-MM-dd').format(now)) {
        dateLabel = "Today";
      } else if (DateFormat('yyyy-MM-dd').format(dateTime) ==
          DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)))) {
        dateLabel = "Yesterday";
      } else {
        dateLabel = DateFormat('dd MMM yyyy').format(dateTime);
      }

      if (groupedNotifications[dateLabel] == null) {
        groupedNotifications[dateLabel] = [];
      }
      groupedNotifications[dateLabel]!.add(notification);
    }

    return groupedNotifications;
  }

  int countNotificationsForCurrentWeek(List<dynamic> notifications) {

    final now = DateTime.now();
    final currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
    final currentWeekEnd = currentWeekStart.add(const Duration(days: 6));

    return notifications.where((notification) {
      return DateTime.parse(notification["createdAt"]).isAfter(currentWeekStart) &&
          DateTime.parse(notification["createdAt"]).isBefore(currentWeekEnd);
    }).length;

  }

  Future getAllStations() async {
    getPetrolStation();
    getDieselStations();
    getGasStations();
    getKeroseneStations();
    updateCurrentLocation();
    getAllStationsData();
  }

  Future getPetrolStation() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "PetrolStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updatePetrolStation(responseData["data"]["data"]);
      _petrolToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getDieselStations() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "DieselStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateDieselStation(responseData["data"]["data"]);
      _dieselToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getGasStations() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "GasStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateGasStation(responseData["data"]["data"]);
      _gasToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getKeroseneStations() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "KeroseneStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateKeroseneStation(responseData["data"]["data"]);
      _keroseneToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future refreshPetrolStation() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "PetrolStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      List<dynamic> newData = List<dynamic>.from(responseData["data"]["data"]);

      _petrolStations = newData;
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future refreshDieselStations() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "DieselStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      List<dynamic> newData = List<dynamic>.from(responseData["data"]["data"]);

      _dieselStations = newData;
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future refreshGasStations() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "GasStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      List<dynamic> newData = List<dynamic>.from(responseData["data"]["data"]);

      _gasStations = newData;
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future refreshKeroseneStations() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "KeroseneStation",
        keyword: locationData["state"],
        pageToken: "");
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      List<dynamic> newData = List<dynamic>.from(responseData["data"]["data"]);

      _keroseneStations = newData;
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future loadMorePetrolStation() async {
    updateIsFetchingMore(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "PetrolStation",
        keyword: locationData["state"],
        pageToken: _petrolToken);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsFetchingMore(false);

      List<dynamic> newData = responseData["data"]["data"];

      _petrolStations.addAll(newData);
      _petrolToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsFetchingMore(false);
    }

    update();
  }

  Future loadMoreDieselStations() async {
    updateIsFetchingMore(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "DieselStation",
        keyword: locationData["state"],
        pageToken: _dieselToken);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsFetchingMore(false);

      List<dynamic> newData = responseData["data"]["data"];

      _dieselStations.addAll(newData);
      _dieselToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsFetchingMore(false);
    }

    update();
  }

  Future loadMoreGasStations() async {
    updateIsFetchingMore(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "GasStation",
        keyword: locationData["state"],
        pageToken: _gasToken);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsFetchingMore(false);

      List<dynamic> newData = responseData["data"]["data"];

      _gasStations.addAll(newData);
      _gasToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsFetchingMore(false);
    }

    update();
  }

  Future loadMoreKeroseneStations() async {
    updateIsFetchingMore(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().getAllStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        type: "KeroseneStation",
        keyword: locationData["state"],
        pageToken: _keroseneToken);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsFetchingMore(false);
      List<dynamic> newData = responseData["data"]["data"];

      _keroseneStations.addAll(newData);
      _keroseneToken = responseData["data"]["nextPageToken"];
    } else {
      updateIsFetchingMore(false);
    }

    update();
  }

  Future submitStationPrice({id, listItem, index, type}) async {
    updateIsLoading(true);

    ProfileStateController profileStateController =
        Get.find<ProfileStateController>();

    var data = {
      "stationId": id,
      "fuelPrice": num.parse(_fuelPrice.text.isEmpty ? "0" : _fuelPrice.text),
      "isFuelInStock": _isPetrolInStock,
      "kerosene":
          num.parse(_kerosenePrice.text.isEmpty ? "0" : _kerosenePrice.text),
      "isKeroseneInStock": _isKeroseneInStock,
      "gasPrice": num.parse(_gasPrice.text.isEmpty ? "0" : _gasPrice.text),
      "isGasInStock": _isGasInStock,
      "dieselPrice":
          num.parse(_dieselPrice.text.isEmpty ? "0" : _dieselPrice.text),
      "isDieselInStock": _isDieselInStock
    };

    var response = await StationServices().updateStationPriceService(data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.back();

      Get.offNamed(pumpScaleScreen, arguments: {
        "index": index,
        "listItem": listItem,
        "station": _station,
        "type": type
      });

      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);

      listItem[index]["stationDetails"]["petrolPrice"] =
          num.parse(_fuelPrice.text.isEmpty ? "0" : _fuelPrice.text);
      listItem[index]["stationDetails"]["dieselPrice"] =
          num.parse(_dieselPrice.text.isEmpty ? "0" : _dieselPrice.text);
      listItem[index]["stationDetails"]["gasPrice"] =
          num.parse(_gasPrice.text.isEmpty ? "0" : _gasPrice.text);
      listItem[index]["stationDetails"]["kerosene"] =
          num.parse(_kerosenePrice.text.isEmpty ? "0" : _kerosenePrice.text);
      listItem[index]["stationDetails"]["isFuelInStock"] = _isPetrolInStock;
      listItem[index]["stationDetails"]["isKeroseneInStock"] =
          _isKeroseneInStock;
      listItem[index]["stationDetails"]["isGasInStock"] = _isGasInStock;
      listItem[index]["stationDetails"]["isDieselInStock"] = _isDieselInStock;
      listItem[index]["stationDetails"]["priceLastUpdatedBy"] =
          profileStateController.user.userName;
      listItem[index]["stationDetails"]["priceLastUpdated"] =
          DateTime.now().toString();

      _fuelPrice.clear();
      _dieselPrice.clear();
      _gasPrice.clear();
      _kerosenePrice.clear();
      updateIsPetrolInStock(false);
      updateIsDieselInStock(false);
      updateIsKeroseneInStock(false);
      updateIsGasInStock(false);
    } else {
      updateIsLoading(false);

      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future submitMeterReport({id, listItem, index, type}) async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    ProfileStateController profileStateController =
        Get.find<ProfileStateController>();

    var data = {
      "pumpAccuracy": _selectedPumpAccuracy,
    };

    var query = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
    };

    var response = await StationServices()
        .updateStationMeterReportService(data, id, query);
    var responseData = response!.data;
    log(responseData.toString());

    if (responseData["status"]) {
      updateIsLoading(false);

      Get.back();
      Get.offNamed(queueReportScreen, arguments: {
        "index": index,
        "listItem": listItem,
        "station": _station,
        "type": type
      });

      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);

      listItem[index]["stationDetails"]["pumpAccuracy"] = _selectedPumpAccuracy;
      listItem[index]["stationDetails"]["reportLastUpdatedBy"] =
          profileStateController.user.userName;
      listItem[index]["stationDetails"]["reportLastUpdated"] =
          DateTime.now().toString();

      updateSelectedPumpAccuracy("");
    } else {
      updateIsLoading(false);

      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future submitQueueReport(context, {id, listItem, index}) async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    ProfileStateController profileStateController =
        Get.find<ProfileStateController>();

    var data = {
      "queue": _selectedQueueReport,
    };

    var query = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
    };

    var response = await StationServices()
        .updateStationQueueReportService(data, id, query);
    var responseData = response!.data;
    log(responseData.toString());

    if (responseData["status"]) {
      updateIsLoading(false);

      Navigator.pop(context);
      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);

      listItem[index]["stationDetails"]["queue"] = _selectedQueueReport;
      listItem[index]["stationDetails"]["queueLastUpdatedBy"] =
          profileStateController.user.userName;
      listItem[index]["stationDetails"]["queueLastUpdated"] =
          DateTime.now().toString();

      updateSelectedQueueReport("");
    } else {
      updateIsLoading(false);

      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future rateStation({id, listItem, index}) async {
    updateIsLoading(true);

    var data = {
      "score": _ratingText,
      "reviewMessage": _reviewText.text,
    };

    var response = await StationServices().rateAStationService(data, id);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      Get.back();
      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);

      listItem[index]["stationDetails"]["rating"] = _ratingText;

      refreshReviews(id);
    } else {
      updateIsLoading(false);

      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future editStationReview(id) async {
    updateIsLoading2(true);

    var data = {
      "score": _ratingText,
      "reviewMessage": _reviewText.text,
    };

    var response = await StationServices().rateAStationService(data, id);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading2(false);

      Get.back();
      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);
      _reviewText.clear();
      _ratingText = 0;

      getUserStationReviews();
    } else {
      updateIsLoading2(false);

      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future getReviews(id) async {
    updateIsLoading(true);

    var response = await StationServices().getStationReviewService(id);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      _stationReviewsModel = StationReviews.fromMap(responseData["data"]);
      updateStationReviews(responseData["data"]["reviews"]);
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future refreshReviews(id) async {
    var response = await StationServices().getStationReviewService(id);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      _stationReviewsModel = StationReviews.fromMap(responseData["data"]);
      updateStationReviews(responseData["data"]["reviews"]);
    } else {}

    update();
  }

  Future getFavouriteStations({name = ""}) async {
    updateIsLoading2(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var data = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
    };

    var response =
        await StationServices().getAllFavoriteServices(query: data, name: name);

    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading2(false);

      // Clear the previous station lists
      _allFavouriteStations = [];
      _favpetrolStations = [];
      _favgasStations = [];
      _favdieselStations = [];
      _favkeroseneStations = [];

      // Iterate over each station in the response data
      responseData["data"].forEach((station) {
        var stationDetails = station["stationDetails"];
        List<dynamic> stationTypes = stationDetails["stationType"];

        // Add the station to the relevant lists based on station type
        if (stationTypes.contains("PetrolStation")) {
          _favpetrolStations.add(station);
        }
        if (stationTypes.contains("DieselStation")) {
          _favgasStations.add(station);
        }
        if (stationTypes.contains("GasStation")) {
          _favdieselStations.add(station);
        }
        if (stationTypes.contains("KeroseneStation")) {
          _favkeroseneStations.add(station);
        }
        _allFavouriteStations.add(station);
      });
    } else {
      updateIsLoading2(false);
    }

    update();
  }

  Future addToFavourites({id}) async {
    var response = await StationServices().addToFavoriteService(id);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future removeFromFavourites({id}) async {
    var response = await StationServices().removeFromFavoriteService(id);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar("Error", responseData["message"],
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    update();
  }

  Future searchForStation() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var response = await StationServices().searchForStationServices(
        longitude: locationData["longitude"],
        latitude: locationData["latitude"],
        location: locationData["state"],
        searchQuery: _searchText.text);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      // Clear the previous station lists
      _allSearchStations = [];
      _searchPetrolStations = [];
      _searchGasStations = [];
      _searchKeroseneStations = [];
      _searchDieselStations = [];

      // Iterate over each station in the response data
      responseData["data"].forEach((station) {
        var stationDetails = station["stationDetails"];
        List<dynamic> stationTypes = stationDetails["stationType"];

        // Add the station to the relevant lists based on station type
        if (stationTypes.contains("PetrolStation")) {
          _searchPetrolStations.add(station);
        }
        if (stationTypes.contains("DieselStation")) {
          _searchDieselStations.add(station);
        }
        if (stationTypes.contains("GasStation")) {
          _searchGasStations.add(station);
        }
        if (stationTypes.contains("KeroseneStation")) {
          _searchKeroseneStations.add(station);
        }
        // Add the station to the allSearchStations list
        _allSearchStations.add(station);
      });
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future filterStation() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    Map<String, dynamic> cleanMap(Map<String, dynamic> originalMap) {
      originalMap.removeWhere(
          (key, value) => value == null || (value is String && value.isEmpty));
      return originalMap;
    }

    var data = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
      "locationKeyword": locationData["state"],
      "pageNumber": 1,
      "pageSize": 20,
      "showOnlyOpenStations": _showOnlyOpenStations,
      "pumpAccuracy": _selectedPumpAccuracy,
      "minDistance": _minDistance,
      "maxDistance": _maxDistance,
      "minPrice": _minPrice,
      "maxPrice": _maxPrice,
      "lastUpdated": _selectedTimeFilterValue,
      "rating": int.parse(_selectedRatingFilter!.isEmpty
                  ? "0"
                  : _selectedRatingFilter!) ==
              0
          ? null
          : int.parse(
              _selectedRatingFilter!.isEmpty ? "0" : _selectedRatingFilter!),
      ..._productFilter
    };

    data = cleanMap(data);

    log(data.toString());

    var response = await StationServices().filterStationService(data: data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      _allSearchStations = [];
      _searchPetrolStations = [];
      _searchGasStations = [];
      _searchKeroseneStations = [];
      _searchDieselStations = [];

      responseData["data"]["data"].forEach((station) {
        var stationDetails = station["stationDetails"];
        List<dynamic> stationTypes = stationDetails["stationType"];

        if (stationTypes.contains("PetrolStation")) {
          _searchPetrolStations.add(station);
        }
        if (stationTypes.contains("DieselStation")) {
          _searchDieselStations.add(station);
        }
        if (stationTypes.contains("GasStation")) {
          _searchGasStations.add(station);
        }
        if (stationTypes.contains("KeroseneStation")) {
          _searchKeroseneStations.add(station);
        }
        _allSearchStations.add(station);
      });

      updateIsSearchActive();
      Get.back();
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getAllStationsData() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    
    var data = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
      "locationKeyword": locationData["state"],
      "petrol": true,
      "diesel": true,
      "kerosene": true,
      "gas": true,
      "pageNumber": 1,
      "pageSize": 20,
    };

    log(data.toString());

    var response = await StationServices().filterStationService(data: data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateAllStations(responseData["data"]["data"]);
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future fetchMoreAllStationData({currentPage}) async {
    updateIsFetchingMore(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var data = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
      "locationKeyword": locationData["state"],
      "petrol": true,
      "diesel": true,
      "kerosene": true,
      "gas": true,
      "pageNumber": currentPage,
      "pageSize": 20,
    };

    log(data.toString());

    var response = await StationServices().filterStationService(data: data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsFetchingMore(false);

      final uniqueStations = {
        for (var station in responseData["data"]["data"])
          station["stationDetails"]['name']: station
      }.values.toList();

      _allStations.addAll(uniqueStations);
    } else {
      updateIsFetchingMore(false);
    }

    update();
  }

  Future refreshAllStationData() async {
    updateIsLoading(true);

    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> locationData = jsonDecode(encodedData);

    var data = {
      "longitude": locationData["longitude"],
      "latitude": locationData["latitude"],
      "locationKeyword": locationData["state"],
      "petrol": true,
      "diesel": true,
      "kerosene": true,
      "gas": true,
      "pageSize": 20,
    };

    log(data.toString());

    var response = await StationServices().filterStationService(data: data);
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateAllStations(responseData["data"]["data"]);
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getPriceReference() async {
    var response = await StationServices().getPriceReferenceService();
    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      _priceReference = PriceReference.fromMap(responseData);
    } else {}

    update();
  }

  Future getUserStationReviews() async {
    updateIsLoading(true);

    var response = await StationServices().getUserReviewService();

    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateUserStationReviews(responseData["data"]);
    } else {
      updateIsLoading(false);
    }

    update();
  }

  Future getAllNotifications() async {
    updateIsLoading(true);

    var response = await NotificationApiServices().getAllNotificationService();

    var responseData = response!.data;
    log(responseData.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      updateIsLoading(false);

      updateUserNotification(responseData["data"]);
    } else {
      updateIsLoading(false);
    }

    update();
  }


}
