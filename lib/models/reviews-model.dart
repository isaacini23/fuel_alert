// To parse this JSON data, do
//
//     final stationReviews = stationReviewsFromMap(jsonString);

import 'dart:convert';

StationReviews stationReviewsFromMap(String str) => StationReviews.fromMap(json.decode(str));

String stationReviewsToMap(StationReviews data) => json.encode(data.toMap());

class StationReviews {
    int? stationId;
    String? name;
    String? address;
    int? averageRating;
    RatingPercentages? ratingPercentages;
    List<Review>? reviews;

    StationReviews({
        this.stationId,
        this.name,
        this.address,
        this.averageRating,
        this.ratingPercentages,
        this.reviews,
    });

    factory StationReviews.fromMap(Map<String, dynamic> json) => StationReviews(
        stationId: json["stationId"],
        name: json["name"],
        address: json["address"],
        averageRating: json["averageRating"],
        ratingPercentages: json["ratingPercentages"] == null ? null : RatingPercentages.fromMap(json["ratingPercentages"]),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "stationId": stationId,
        "name": name,
        "address": address,
        "averageRating": averageRating,
        "ratingPercentages": ratingPercentages?.toMap(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
    };
}

class RatingPercentages {
    int? the5;
    int? the4;
    int? the3;
    int? the2;
    int? the1;

    RatingPercentages({
        this.the5,
        this.the4,
        this.the3,
        this.the2,
        this.the1,
    });

    factory RatingPercentages.fromMap(Map<String, dynamic> json) => RatingPercentages(
        the5: json["5"] ?? 0,
        the4: json["4"] ?? 0,
        the3: json["3"] ?? 0,
        the2: json["2"] ?? 0,
        the1: json["1"] ?? 0,
    );

    Map<String, dynamic> toMap() => {
        "5": the5,
        "4": the4,
        "3": the3,
        "2": the2,
        "1": the1,
    };
}

class Review {
    String? userName;
    int? score;
    String? reviewMessage;

    Review({
        this.userName,
        this.score,
        this.reviewMessage,
    });

    factory Review.fromMap(Map<String, dynamic> json) => Review(
        userName: json["userName"],
        score: json["score"],
        reviewMessage: json["reviewMessage"],
    );

    Map<String, dynamic> toMap() => {
        "userName": userName,
        "score": score,
        "reviewMessage": reviewMessage,
    };
}
