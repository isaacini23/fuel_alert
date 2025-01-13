import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/custom/custom-marker.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/custom/custom-station-marker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:ui' as ui;

// ignore: must_be_immutable
class MainMapView extends StatefulWidget {

  String? type;

  MainMapView({super.key, required this.type});

  @override
  State<MainMapView> createState() => _MainMapViewState();
}

class _MainMapViewState extends State<MainMapView> with SingleTickerProviderStateMixin {
  final HomeStateController _homeStateController =
      Get.find<HomeStateController>();
  LatLng _initialPosition = const LatLng(0, 0);
  String selectedMarkerId = "";
  GoogleMapController? _mapController;
  double? userLongitude;
  double? userLatitude;
  final SwiperController _scrollController = SwiperController();
  late AnimationController _animationController;
  late BitmapDescriptor redMarker = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor yellowMarker = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor greenMarker = BitmapDescriptor.defaultMarker;
  Set<Marker> _markers = {};
  Set<Marker> _markers2 = {};
  final GlobalKey _repaintKey = GlobalKey();
  final GlobalKey _repaintKey2 = GlobalKey();
  

  updateUserCurrentLocation() async {
    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> _locationData = jsonDecode(encodedData);
    userLatitude = _locationData["latitude"];
    userLongitude = _locationData["longitude"];
    setState(() {});
  }

  void updateCurrentPosition({longitude, latitude, name}) async {
    setState(() {
      _initialPosition = LatLng(latitude, longitude);
    });
  }

  num getFuelPrice(String stationType, Map<String, dynamic> stationDetails) {
    switch (stationType) {
      case "PetrolStation":
        return stationDetails["petrolPrice"] ?? 0.0;
      case "DieselStation":
        return stationDetails["dieselPrice"] ?? 0.0;
      case "GasStation":
        return stationDetails["gasPrice"] ?? 0.0;
      case "KeroseneStation":
        return stationDetails["kerosene"] ?? 0.0;
      default:
        return 0.0;
    }
  }

  Color getMarkerColor(num currentPrice, String stationType) {
    log(_homeStateController.priceReference.toMap().toString());
    num referencePrice = stationType.split("Station").first.toLowerCase() ==
            "gas"
        ? _homeStateController.priceReference.toMap()["cookingGas"] ?? 0.0
        : _homeStateController.priceReference
                .toMap()[stationType.split("Station").first.toLowerCase()] ??
            0.0;
    num difference = currentPrice - referencePrice;

    num percentageDifference = (difference / referencePrice) * 100;

    if (percentageDifference > 20) {
      return const Color(0xffEA251D);
    } else if (percentageDifference > 2 && percentageDifference < 20) {
      return const Color(0xffEBBC46);
    } else {
      return const Color(0xff009933);
    }
  }

  Future<Uint8List> _captureMarkerImage(Color markerColor, bool isSelected, num fuelPrice) async {

    setState(() {
      _markerColor = markerColor;
      _isSelected = isSelected;
      _fuelPrice = fuelPrice;
    });

    await Future.delayed(Duration(milliseconds: 100));

    RenderRepaintBoundary boundary = _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _captureMarkerImage2() async {

    await Future.delayed(const Duration(milliseconds: 100));

    RenderRepaintBoundary boundary = _repaintKey2.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Set<Marker>> _buildMarkers() async {
    Set<Marker> markers = {};
    for (var station in _homeStateController.mapViewStations) {
      try {
        final stationId = station["stationDetails"]['id'].toString();
        final stationType = station["stationDetails"]["stationType"].isNotEmpty
            ? station["stationDetails"]["stationType"][0]
            : "";
        final fuelPrice = getFuelPrice(
            widget.type!.isEmpty ? stationType : widget.type!,
            station["stationDetails"]);
        final markerColor = getMarkerColor(fuelPrice, stationType);
        final isSelected = selectedMarkerId == station["stationDetails"]['id'].toString();
        Uint8List image = await _captureMarkerImage(markerColor, isSelected, fuelPrice);

        final Marker marker = Marker(
          markerId: MarkerId(stationId),
          position: LatLng(
            station["stationDetails"]['latitude'],
            station["stationDetails"]["longitude"],
          ),
          icon: BitmapDescriptor.bytes(image),
          onTap: () {
          final index = _homeStateController.mapViewStations.indexWhere(
                (element) => element["stationDetails"]['id'] == station["stationDetails"]['id'],
              );
              if (index != -1) {
                _scrollController.move(index);
                setState(() {
                  selectedMarkerId = station["stationDetails"]['id'].toString();
                });

              }
          },
        );

        markers.add(marker);
      } catch (e, stack) {
        log("Error creating marker for station: $e\n$stack");
      }
    }
    return markers;
  }

  Future<Set<Marker>> _buildMarkers2() async {
    Set<Marker> markers = {};
      try {
        Uint8List image = await _captureMarkerImage2();

        final Marker marker = Marker(
          markerId: const MarkerId("userMarker"),
          position: LatLng(
            userLatitude ?? 0.0, 
            userLongitude ?? 0.0,
          ),
          icon: BitmapDescriptor.bytes(image),
        );

        markers.add(marker);

        return markers;
      } catch (e, stack) {
        log("Error creating marker for station: $e\n$stack");
        return {};
      }
    }

  Future<void> _loadMarkers() async {
    Set<Marker> markers = await _buildMarkers();
    Set<Marker> markers2 = await _buildMarkers2();
    setState(() {
      _markers = markers;
      _markers2 = markers2;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUserCurrentLocation();
    updateCurrentPosition(
      latitude: _homeStateController.station.stationDetails!.latitude,
      longitude: _homeStateController.station.stationDetails!.longitude,
      name: _homeStateController.station.stationDetails!.name,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMarkers();
    });
  }

  Color _markerColor = Colors.transparent;
  bool _isSelected = false;
  num _fuelPrice = 0;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeStateController>(builder: (controller) {
      return Scaffold(
        body: _initialPosition.latitude == 0 && _initialPosition.longitude == 0
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 15.0,
                    ),
                    mapType: controller.mapTypes[controller.selectedMapType],
                    myLocationButtonEnabled: false,
                    markers: {
                      ..._markers,
                      ..._markers2
                    },
                    onMapCreated: (GoogleMapController gController) {
                      _mapController = gController;
                    },
                  ),

                  Positioned(
                    top: -100, // Position it off-screen
                    child: RepaintBoundary(
                      key: _repaintKey,
                      child: CustomStationMarker(
                        markerColor: _markerColor, // Use a transparent color to avoid visibility
                        isSelected: _isSelected,
                        fuelPrice: _fuelPrice,
                      ),
                    ),
                  ),

                  Positioned(
                    top: -100,
                    child: RepaintBoundary(
                      key: _repaintKey2,
                      child: Center(child: GlowingLocationMarker()),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0, 
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        height: 200,
                        child: Swiper(
                            controller: _scrollController,
                            itemCount: controller.mapViewStations.length,
                            onIndexChanged: (value) {
                              controller.updateCurrentStationIndex(value);
                              controller.updateStationModel(
                                  controller.mapViewStations[value]);

                              final stationDetails =
                                  controller.station.stationDetails!;
                              final latitude = stationDetails.latitude!;
                              final longitude = stationDetails.longitude!;
                              final stationId = stationDetails.id!.toString();

                              updateCurrentPosition(
                                latitude: latitude,
                                longitude: longitude,
                                name: stationDetails.name,
                              );

                              setState(() {
                                selectedMarkerId = stationId;
                                log(selectedMarkerId);
                              });

                              _animateCameraToStation(
                                  latitude, longitude, stationId);

                            },
                            itemBuilder: (context, index) {
                              List<String> stationTypes = List<String>.from(
                                  controller.mapViewStations[index]
                                      ["stationDetails"]["stationType"]);
                              Map<String, dynamic> stationDetails = controller
                                  .mapViewStations[index]["stationDetails"];

                              num getPriceForFirstType(String type) {
                                switch (type) {
                                  case 'PetrolStation':
                                    return stationDetails["petrolPrice"] ?? 0.0;
                                  case 'DieselStation':
                                    return stationDetails["dieselPrice"] ?? 0.0;
                                  case 'GasStation':
                                    return stationDetails["gasPrice"] ?? 0.0;
                                  case 'KeroseneStation':
                                    return stationDetails["kerosene"] ??
                                        0.0;
                                  default:
                                    return 0;
                                }
                              }

                              num firstTypePrice = getPriceForFirstType(
                                  widget.type!.isEmpty
                                      ? stationTypes.first
                                      : (widget.type ?? ""));

                              return Center(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 4.24),
                                                blurRadius: 31.24,
                                                spreadRadius: 0,
                                                color: Colors.black
                                                    .withOpacity(0.05)),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: InkWell(
                                        onTap: () {
                                          controller.updateStationModel(
                                              controller
                                                  .mapViewStations[index]);
                                          Get.toNamed(stationDetailsScreen,
                                              arguments: {
                                                "type": widget.type!.isEmpty ? stationTypes[0] : widget.type,
                                                "station": controller.station,
                                                "index": index,
                                                "listItem":
                                                    controller.mapViewStations
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 8,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .mapViewStations[
                                                              index]
                                                              ["stationDetails"]
                                                              ["name"]
                                                          .toString()
                                                          .toUpperCase(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headlineLarge
                                                                  ?.color,
                                                          fontFamily:
                                                              "PoppinsSemiBold",
                                                          fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      controller
                                                          .mapViewStations[
                                                              index]
                                                              ["stationDetails"]
                                                              ["address"]
                                                          .toString()
                                                          .capitalizeFirst!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff999999),
                                                          fontFamily:
                                                              "PoppinsMeds",
                                                          fontSize: 13),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        RichText(
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: controller.mapViewStations[index]
                                                                            [
                                                                            "stationDetails"]
                                                                        [
                                                                        "openNowDisplay"] ==
                                                                    "True"
                                                                ? "Open"
                                                                : "Closed ",
                                                            style: TextStyle(
                                                                color: controller.mapViewStations[index]["stationDetails"]
                                                                            [
                                                                            "openNowDisplay"] ==
                                                                        "True"
                                                                    ? const Color(
                                                                        0xff009933)
                                                                    : const Color(
                                                                        0xffDE4841),
                                                                fontFamily:
                                                                    "PoppinsMeds",
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.location_on,
                                                              color: Color(
                                                                  0xff009933),
                                                              size: 15,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            AutoSizeText(
                                                              controller.formatDistance(
                                                                  controller.mapViewStations[
                                                                          index]
                                                                      [
                                                                      "distance"]),
                                                              minFontSize: 8,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff999999),
                                                                  fontFamily:
                                                                      "PoppinsMeds",
                                                                  fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .launchGoogleMaps(
                                                              longitude: controller
                                                                              .mapViewStations[
                                                                          index]
                                                                      [
                                                                      "stationDetails"]
                                                                  ["longitude"],
                                                              latitude: controller
                                                                              .mapViewStations[
                                                                          index]
                                                                      [
                                                                      "stationDetails"]
                                                                  ["latitude"],
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .highlightColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/images/Time icon.svg"),
                                                                const SizedBox(
                                                                  width: 3,
                                                                ),
                                                                const AutoSizeText(
                                                                  minFontSize:
                                                                      7,
                                                                  "Navigation",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff9599AD),
                                                                    fontFamily:
                                                                        "PoppinsMeds",
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            controller.toggleSelectedFavoriteList(
                                                                index: index,
                                                                listItem: controller
                                                                    .mapViewStations);
                                                          },
                                                          child: Icon(
                                                              Icons.favorite,
                                                              color: controller.mapViewStations[
                                                                              index]
                                                                          [
                                                                          "stationDetails"]
                                                                      [
                                                                      "isFavorite"]
                                                                  ? const Color(
                                                                      0xff009933)
                                                                  : const Color(
                                                                      0xff9C9C9C)),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            (firstTypePrice == 0)
                                                ? Expanded(
                                                    flex: 4,
                                                    child: DottedBorder(
                                                      borderType:
                                                          BorderType.RRect,
                                                      radius:
                                                          const Radius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xffB0DFC0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .updateStationModel(
                                                                  controller
                                                                          .mapViewStations[
                                                                      index]);
                                                          Get.toNamed(
                                                              submitPriceScreen,
                                                              arguments: {
                                                                "type": widget.type!.isEmpty ? stationTypes[0] : widget.type,
                                                                "station":
                                                                    controller
                                                                        .station,
                                                                "index": index,
                                                                "listItem":
                                                                    controller
                                                                        .mapViewStations
                                                              });
                                                        },
                                                        child: Container(
                                                          height: 111,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .hoverColor,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        offset: const Offset(0,
                                                                            3.53),
                                                                        blurRadius:
                                                                            25.85,
                                                                        spreadRadius:
                                                                            0,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.10)),
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                          child: Center(
                                                            child: AutoSizeText.rich(
                                                                minFontSize: 5,
                                                                textAlign: TextAlign.center,
                                                                TextSpan(
                                                                  text:
                                                                      "Be the first to\n",
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xff009933),
                                                                      fontFamily:
                                                                          "PoppinsMeds",
                                                                      fontSize:
                                                                          12),
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "Update\n",
                                                                      style: TextStyle(
                                                                          color: Theme.of(context)
                                                                              .textTheme
                                                                              .headlineLarge
                                                                              ?.color,
                                                                          fontFamily:
                                                                              "PoppinsSemiBold",
                                                                          fontSize:
                                                                              21),
                                                                    ),
                                                                    const TextSpan(
                                                                      text:
                                                                          "the price 😇",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0xff999999),
                                                                          fontFamily:
                                                                              "PoppinsMeds",
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .hoverColor,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset:
                                                                    const Offset(
                                                                        0,
                                                                        3.53),
                                                                blurRadius:
                                                                    25.85,
                                                                spreadRadius: 0,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.10)),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        children: [
                                                          controller.mapViewStations[
                                                                              index]
                                                                          [
                                                                          "stationDetails"]
                                                                      [
                                                                      "pumpAccuracy"] ==
                                                                  "NoReport"
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : SvgPicture
                                                                  .asset(
                                                                  controller.mapViewStations[index]["stationDetails"]
                                                                              [
                                                                              "pumpAccuracy"] ==
                                                                          "Excellent"
                                                                      ? "assets/images/excellent-pump.svg"
                                                                      : controller.mapViewStations[index]["stationDetails"]["pumpAccuracy"] ==
                                                                              "Good"
                                                                          ? "assets/images/good-pump.svg"
                                                                          : controller.mapViewStations[index]["stationDetails"]["pumpAccuracy"] == "Fair"
                                                                              ? "assets/images/fair-pump.svg"
                                                                              : controller.mapViewStations[index]["stationDetails"]["pumpAccuracy"] == "Poor"
                                                                                  ? "assets/images/poor-pump.svg"
                                                                                  : "",
                                                                ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          controller.mapViewStations[
                                                                              index]
                                                                          [
                                                                          "stationDetails"]
                                                                      [
                                                                      "queue"] ==
                                                                  "NoReport"
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Text(
                                                                  "${controller.convertRangeToMiddle(controller.mapViewStations[index]["stationDetails"]["queue"])}+ people in queue",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xff999999),
                                                                      fontFamily:
                                                                          "PoppinsMeds",
                                                                      fontSize:
                                                                          9),
                                                                ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            (widget.type!.isEmpty)?
                                                            controller
                                                                .mapViewStations[
                                                                    index][
                                                                    "stationDetails"]
                                                                    [
                                                                    "stationType"]
                                                                    [0]
                                                                .toString()
                                                                .replaceAll(
                                                                    "Station",
                                                                    "")
                                                                .toUpperCase() : widget.type!.toString()
                                                                .replaceAll(
                                                                    "Station",
                                                                    "").toUpperCase(),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF009933),
                                                                fontFamily:
                                                                    "PoppinsMeds",
                                                                fontSize: 13),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          AutoSizeText.rich(
                                                            minFontSize: 5,
                                                            maxLines: 1,
                                                            TextSpan(
                                                                text: "₦",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headlineLarge
                                                                        ?.color,
                                                                    fontFamily:
                                                                        "InterSemiBold",
                                                                    fontSize:
                                                                        24),
                                                                children: [
                                                                  TextSpan(
                                                                    text: controller.mapViewStations[index]["stationDetails"]["stationType"][0] ==
                                                                            "GasStation"
                                                                        ? "${controller.mapViewStations[index]["stationDetails"]["gasPrice"]}/KG"
                                                                        : "$firstTypePrice/L",
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .textTheme
                                                                            .headlineLarge
                                                                            ?.color,
                                                                        fontFamily:
                                                                            "PoppinsSemiBold",
                                                                        fontSize:
                                                                            24),
                                                                  )
                                                                ]),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            3.42),
                                                                    color: const Color(
                                                                            0xff009933)
                                                                        .withOpacity(
                                                                            0.05)),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Iconsax
                                                                          .star5,
                                                                      size: 9,
                                                                      color: Color(
                                                                          0xff009933),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      controller
                                                                          .mapViewStations[
                                                                              index]
                                                                              [
                                                                              "stationDetails"]
                                                                              [
                                                                              "rating"]
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xff009933),
                                                                          fontSize:
                                                                              9),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "(${controller.mapViewStations[index]["stationDetails"]["noOfReviews"]} Reviews)",
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff009933),
                                                                    fontSize:
                                                                        9),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          (controller.mapViewStations[
                                                                              index]
                                                                          [
                                                                          "stationDetails"]
                                                                      [
                                                                      "priceLastUpdated"] ==
                                                                  null)
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Text(
                                                                  timeago.format(DateTime.parse(
                                                                      controller.mapViewStations[index]
                                                                              [
                                                                              "stationDetails"]
                                                                          [
                                                                          "priceLastUpdated"])),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  maxLines: 2,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xff999999),
                                                                      fontFamily:
                                                                          "PoppinsMeds",
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      ),
                    ),
                  ),
                  Positioned(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  controller.updateStationModel(
                                      controller.mapViewStations[0]);
                                  (controller.isMapVisible)
                                      ? controller.toggleIsMapVisible()
                                      : null;
                                  (controller.isFavMapView)
                                      ? controller.toggleIsfavMapViewVisible()
                                      : null;
                                  controller.updateMapViewStations(
                                      controller.petrolStations);
                                },
                                child: SvgPicture.asset(
                                    "assets/images/Close icon.svg")),
                            PopupMenuButton(
                              icon:Container(
                              height: 37.92,
                              width: 37.92,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xffD9F0E0)
                                  ),
                                  color: const Color(0xffE6F5EB)
                                ),
                                child: const Icon(
                                  Icons.more_horiz,
                                  color: Color(0xff626262),
                                  size: 25,
                                ),
                              ),
                              itemBuilder:(context) => List.generate(
                                controller.mapTypes.length,
                                (index) => PopupMenuItem(
                                  onTap: () {
                                    controller.updateSelectedMapType(index);
                                  },
                                  value: index,
                                  child: Text(
                                    controller.mapTypes[index].name.capitalize!,
                                  ),
                                )
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      );
    });
  }

  void _animateCameraToStation(
      double latitude, double longitude, String stationId) {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 15))
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

}