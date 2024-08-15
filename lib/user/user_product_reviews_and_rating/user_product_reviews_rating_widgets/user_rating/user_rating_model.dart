// To parse this JSON data, do
//
//     final Rate = RateFromJson(jsonString);

import 'dart:convert';

Rate rateFromJson(String str) => Rate.fromJson(json.decode(str));

String rateToJson(Rate data) => json.encode(data.toJson());
class Rate {
  int id;
  int bookId;
  int userId;
  double stars;
  DateTime createdAt;
  DateTime updatedAt;

  Rate({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.stars,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["id"],
        bookId: json["book_id"],
        userId: json["user_id"],
        stars: json["stars"] is int
            ? (json["stars"] as int).toDouble()
            : double.parse(json["stars"].toString()), // تحويل إلى double
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "user_id": userId,
        "stars": stars,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
