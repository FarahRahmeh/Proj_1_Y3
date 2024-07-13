import 'dart:convert';

import '../../models/cafe_model.dart';

class AllCategories {
  int id;
  int cafeId;
  String genre;

  AllCategories({
    required this.id,
    required this.cafeId,
    required this.genre,
  });

  factory AllCategories.fromJson(Map<String, dynamic> json) => AllCategories(
        id: json["id"],
        cafeId: json["cafe_id"],
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cafe_id": cafeId,
        "genre": genre,
      };
}

List<Cafes> cafesFromJson(String str) =>
    List<Cafes>.from(json.decode(str).map((x) => Cafes.fromJson(x)));

String cafesToJson(List<Cafes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<AllCategories> allCategoriesFromJson(String str) =>
    List<AllCategories>.from(
        json.decode(str).map((x) => AllCategories.fromJson(x)));

String allCategoriesToJson(List<AllCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
