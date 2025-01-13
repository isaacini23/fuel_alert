// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
    String? fullName;
    String? userName;
    dynamic gender;
    String? email;
    dynamic phoneNumber;
    dynamic address;
    int? points;

    User({
        this.fullName,
        this.userName,
        this.gender,
        this.email,
        this.phoneNumber,
        this.address,
        this.points,
    });

    factory User.fromMap(Map<String, dynamic> json) => User(
        fullName: json["fullName"],
        userName: json["userName"],
        gender: json["gender"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        points: json["points"],
    );

    Map<String, dynamic> toMap() => {
        "fullName": fullName,
        "userName": userName,
        "gender": gender,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "points": points,
    };
}
