import 'dart:convert';

import 'cafe_model.dart';

class AllCategories {
  int id;
  int cafeId;
  String genre;
  String image;

  AllCategories({
    required this.id,
    required this.cafeId,
    required this.genre,
    required this.image,
  });

  factory AllCategories.fromJson(Map<String, dynamic> json) => AllCategories(
        id: json["id"],
        cafeId: json["cafe_id"],
        genre: json["genre"].toString(),
        image: json["image"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cafe_id": cafeId,
        "genre": genre,
        "image": image,
      };
}

List<Cafe> cafesFromJson(String str) =>
    List<Cafe>.from(json.decode(str).map((x) => Cafe.fromJson(x)));

String cafesToJson(List<Cafe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<AllCategories> allCategoriesFromJson(String str) =>
    List<AllCategories>.from(
        json.decode(str).map((x) => AllCategories.fromJson(x)));

String allCategoriesToJson(List<AllCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
