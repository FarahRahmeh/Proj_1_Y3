// To parse this JSON data, do
//
//     final genreChallenge = genreChallengeFromJson(jsonString);

import 'dart:convert';

GenreChallenge genreChallengeFromJson(String str) =>
    GenreChallenge.fromJson(json.decode(str));

String genreChallengeToJson(GenreChallenge data) => json.encode(data.toJson());

class GenreChallenge {
  int? id;
  int? cafeId;
  String? genre;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  GenreChallenge({
    this.id,
    this.cafeId,
    this.genre,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory GenreChallenge.fromJson(Map<String, dynamic> json) => GenreChallenge(
        id: json["id"],
        cafeId: json["cafe_id"],
        genre: json["genre"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cafe_id": cafeId,
        "genre": genre,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
