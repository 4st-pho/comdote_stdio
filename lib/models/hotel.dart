import 'package:stdio_week_6/models/review.dart';
import 'package:stdio_week_6/models/location.dart';

import 'dart:convert';

Hotel hotelFromJson(String str) => Hotel.fromJson(json.decode(str));

String hotelToJson(Hotel data) => json.encode(data.toJson());

class Hotel {
  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    required this.createdAt,
  });

  final String id;
  String name;
  Location location;
  String address;
  String description;
  String imagePath;
  double rating;
  List<Review> reviews;
  DateTime createdAt;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
        description: json["description"],
        rating: json["rating"].toDouble(),
        reviews:
            List<Review>.from(json["reviews"].map((e) => Review.fromJson(e))),
        imagePath: json["imagePath"],
        createdAt: DateTime.parse(json["createdAt"])
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "location": location.toJson(),
        "description": description,
        "rating": rating,
        "reviews": List<dynamic>.from(reviews.map((e) => e.toJson())),
        "imagePath": imagePath,
        "createdAt": createdAt.toString(),
      };
}

