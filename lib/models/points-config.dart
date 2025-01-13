// To parse this JSON data, do
//
//     final pointConfig = pointConfigFromMap(jsonString);

import 'dart:convert';

PointConfig pointConfigFromMap(String str) => PointConfig.fromMap(json.decode(str));

String pointConfigToMap(PointConfig data) => json.encode(data.toMap());

class PointConfig {
    int? id;
    int? meterReport;
    int? queueReport;
    int? petrol;
    int? diesel;
    int? kerosene;
    int? cookingGas;
    String? pointsToNairaConversionRate;

    PointConfig({
        this.id,
        this.meterReport,
        this.queueReport,
        this.petrol,
        this.diesel,
        this.kerosene,
        this.cookingGas,
        this.pointsToNairaConversionRate,
    });

    factory PointConfig.fromMap(Map<String, dynamic> json) => PointConfig(
        id: json["id"],
        meterReport: json["meterReport"],
        queueReport: json["queueReport"],
        petrol: json["petrol"],
        diesel: json["diesel"],
        kerosene: json["kerosene"],
        cookingGas: json["cookingGas"],
        pointsToNairaConversionRate: json["pointsToNairaConversionRate"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "meterReport": meterReport,
        "queueReport": queueReport,
        "petrol": petrol,
        "diesel": diesel,
        "kerosene": kerosene,
        "cookingGas": cookingGas,
        "pointsToNairaConversionRate": pointsToNairaConversionRate,
    };
}
