import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  Review({
    required this.content,
    required this.rating,
    required this.uid,
    this.like = 0,
  });

  String content;
  double rating;
  String uid;
  int like;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        content: json["content"],
        rating: json["rating"].toDouble(),
        uid: json["uid"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "rating": rating,
        "uid": uid,
        "like": like,
      };
}

