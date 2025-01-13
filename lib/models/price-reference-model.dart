// To parse this JSON data, do
//
//     final priceReference = priceReferenceFromMap(jsonString);

import 'dart:convert';

PriceReference priceReferenceFromMap(String str) => PriceReference.fromMap(json.decode(str));

String priceReferenceToMap(PriceReference data) => json.encode(data.toMap());

class PriceReference {
    int? petrol;
    int? cookingGas;
    int? diesel;
    int? kerosene;

    PriceReference({
        this.petrol,
        this.cookingGas,
        this.diesel,
        this.kerosene,
    });

    factory PriceReference.fromMap(Map<String, dynamic> json) => PriceReference(
        petrol: json["petrol"],
        cookingGas: json["cookingGas"],
        diesel: json["diesel"],
        kerosene: json["kerosene"],
    );

    Map<String, dynamic> toMap() => {
        "petrol": petrol,
        "cookingGas": cookingGas,
        "diesel": diesel,
        "kerosene": kerosene,
    };
}
