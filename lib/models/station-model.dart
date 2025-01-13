// To parse this JSON data, do
//
//     final station = stationFromMap(jsonString);

import 'dart:convert';

Station stationFromMap(String str) => Station.fromMap(json.decode(str));

String stationToMap(Station data) => json.encode(data.toMap());

class Station {
  StationDetails? stationDetails;
  num? distance;

  Station({
    this.stationDetails,
    this.distance,
  });

  factory Station.fromMap(Map<String, dynamic> json) => Station(
        stationDetails: json["stationDetails"] == null
            ? null
            : StationDetails.fromMap(json["stationDetails"]),
        distance: json["distance"],
      );

  Map<String, dynamic> toMap() => {
        "stationDetails": stationDetails?.toMap(),
        "distance": distance,
      };
}

class StationDetails {
  int? id;
  String? placeId;
  String? pumpAccuracy;
  String? name;
  String? address;
  List<String>? periods;
  num? petrolPrice;
  num? dieselPrice;
  num? gasPrice;
  num? kerosene;
  bool? isFuelInStock;
  bool? isKeroseneInStock;
  bool? isGasInStock;
  dynamic isDieselInStock;
  String? openNowDisplay;
  double? latitude;
  double? longitude;
  String? queue;
  num? rating;
  num? noOfReviews;
  List<String>? stationType;
  bool? isFavorite;
  String? stationState;
  dynamic priceLastUpdatedBy;
  dynamic priceLastUpdated;
  dynamic queueLastUpdatedBy;
  dynamic queueLastUpdated;
  dynamic reportLastUpdatedBy;
  dynamic reportLastUpdated;

  StationDetails({
    this.id,
    this.placeId,
    this.pumpAccuracy,
    this.name,
    this.address,
    this.periods,
    this.petrolPrice,
    this.dieselPrice,
    this.gasPrice,
    this.kerosene,
    this.isFuelInStock,
    this.isKeroseneInStock,
    this.isGasInStock,
    this.isDieselInStock,
    this.openNowDisplay,
    this.latitude,
    this.longitude,
    this.queue,
    this.rating,
    this.noOfReviews,
    this.stationType,
    this.isFavorite,
    this.stationState,
    this.priceLastUpdatedBy,
    this.priceLastUpdated,
    this.queueLastUpdatedBy,
    this.queueLastUpdated,
    this.reportLastUpdatedBy,
    this.reportLastUpdated,
  });

  factory StationDetails.fromMap(Map<String, dynamic> json) => StationDetails(
        id: json["id"],
        placeId: json["placeId"],
        pumpAccuracy: json["pumpAccuracy"],
        name: json["name"],
        address: json["address"],
        periods: json["periods"] == null
            ? []
            : List<String>.from(json["periods"]!.map((x) => x)),
        petrolPrice: json["petrolPrice"],
        dieselPrice: json["dieselPrice"],
        gasPrice: json["gasPrice"],
        kerosene: json["kerosene"],
        isFuelInStock: json["isFuelInStock"],
        isKeroseneInStock: json["isKeroseneInStock"],
        isGasInStock: json["isGasInStock"],
        isDieselInStock: json["isDieselInStock"],
        openNowDisplay: json["openNowDisplay"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        queue: json["queue"],
        rating: json["rating"],
        noOfReviews: json["noOfReviews"],
        stationType: json["stationType"] == null
            ? []
            : List<String>.from(json["stationType"]!.map((x) => x)),
        isFavorite: json["isFavorite"],
        stationState: json["stationState"],
        priceLastUpdatedBy: json["priceLastUpdatedBy"],
        priceLastUpdated: json["priceLastUpdated"],
        queueLastUpdatedBy: json["queueLastUpdatedBy"],
        queueLastUpdated: json["queueLastUpdated"],
        reportLastUpdatedBy: json["reportLastUpdatedBy"],
        reportLastUpdated: json["reportLastUpdated"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "placeId": placeId,
        "pumpAccuracy": pumpAccuracy,
        "name": name,
        "address": address,
        "periods":
            periods == null ? [] : List<dynamic>.from(periods!.map((x) => x)),
        "petrolPrice": petrolPrice,
        "dieselPrice": dieselPrice,
        "gasPrice": gasPrice,
        "kerosene": kerosene,
        "isFuelInStock": isFuelInStock,
        "isKeroseneInStock": isKeroseneInStock,
        "isGasInStock": isGasInStock,
        "isDieselInStock": isDieselInStock,
        "openNowDisplay": openNowDisplay,
        "latitude": latitude,
        "longitude": longitude,
        "queue": queue,
        "rating": rating,
        "noOfReviews": noOfReviews,
        "stationType": stationType == null
            ? []
            : List<dynamic>.from(stationType!.map((x) => x)),
        "isFavorite": isFavorite,
        "stationState": stationState,
        "priceLastUpdatedBy": priceLastUpdatedBy,
        "priceLastUpdated": priceLastUpdated,
        "queueLastUpdatedBy": queueLastUpdatedBy,
        "queueLastUpdated": queueLastUpdated,
        "reportLastUpdatedBy": reportLastUpdatedBy,
        "reportLastUpdated": reportLastUpdated,
      };
}
