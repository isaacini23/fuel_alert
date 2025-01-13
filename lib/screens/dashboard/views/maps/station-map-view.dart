import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fuel_alert/controller/home/home-state-controller.dart';
import 'package:fuel_alert/core/local-storage/local-storage.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/custom/custom-marker.dart';
import 'package:fuel_alert/screens/dashboard/views/maps/custom/custom-station-marker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class StationMapView extends StatefulWidget {
  final double longitude;
  final double latitude;
  final String name;
  final String currentStationType;


  StationMapView({
    super.key,
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.currentStationType,
  });

  @override
  State<StationMapView> createState() => _StationMapViewState();
}

class _StationMapViewState extends State<StationMapView> {
  GoogleMapController? _mapController;
  LatLng _initialPosition = LatLng(0, 0);
  final HomeStateController _homeStateController =
      Get.find<HomeStateController>();
  num? currentPrice;
  Color? markerColor;
  double? userLongitude;
  double? userLatitude;
  final GlobalKey _repaintKey = GlobalKey();
  final GlobalKey _repaintKey2 = GlobalKey();
  Set<Marker> _markers = {};
  Set<Marker> _markers2 = {};


  void updateCurrentPosition(
      {required double longitude, required double latitude}) {
    setState(() {
      _initialPosition = LatLng(latitude, longitude);
    });
  }

  void getFuelPrice(String stationType, Map<String, dynamic> stationDetails) {
    switch (stationType) {
      case "PetrolStation":
        currentPrice = stationDetails["petrolPrice"] ?? 0.0;
        break;
      case "DieselStation":
        currentPrice = stationDetails["dieselPrice"] ?? 0.0;
        break;
      case "GasStation":
        currentPrice = stationDetails["gasPrice"] ?? 0.0;
        break;
      case "KeroseneStation":
        currentPrice = stationDetails["kerosene"] ?? 0.0;
        break;
      default:
        currentPrice = 0.0;
    }
    getMarkerColor(currentPrice!, stationType);
  }

  void getMarkerColor(num currentPrice, String stationType) {
    num referencePrice = _homeStateController.priceReference
            .toMap()[stationType.split("Station").first.toLowerCase()] ??
        0.0;

    num percentageDifference =
        ((currentPrice - referencePrice) / referencePrice) * 100;

    setState(() {
      if (percentageDifference > 20) {
        markerColor = const Color(0xffEA251D); // Higher price
      } else if (percentageDifference > 2 && percentageDifference <= 20) {
        markerColor = const Color(0xffEBBC46); // Slightly higher
      } else {
        markerColor = const Color(0xff009933); // Lower or equal price
      }
    });
  }

  updateUserCurrentLocation() async {
    String encodedData = await LocalStorage().fetchLocationData();
    Map<String, dynamic> _locationData = jsonDecode(encodedData);
    userLatitude = _locationData["latitude"];
    userLongitude = _locationData["longitude"];

    setState(() {});
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
      try {

        Uint8List image = await _captureMarkerImage(markerColor!, false, currentPrice!);

        final Marker marker = Marker(
          markerId: MarkerId(_homeStateController.station.stationDetails?.name ?? ""),
          position: LatLng(
            _homeStateController.station.stationDetails!.latitude!,
            _homeStateController.station.stationDetails!.longitude!,
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_homeStateController.station.stationDetails != null) {
        updateCurrentPosition(
          latitude: _homeStateController.station.stationDetails!.latitude!,
          longitude: _homeStateController.station.stationDetails!.longitude!,
        );
        getFuelPrice(
          widget.currentStationType,
          _homeStateController.station.stationDetails!.toMap(),
        );
      }
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
                  myLocationButtonEnabled: false,
                  markers: {
                    ..._markers,
                    ..._markers2,
                  },
                  onMapCreated: (GoogleMapController gController) {
                    _mapController = gController;
                  },
                ),
                Positioned(
                  top: -100,
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
              ],
            ),
      );
    });
  }
}
