import 'dart:convert';

class CafeShelf {
  int? id;
  int? cafeId;
  String? genre;

  CafeShelf({
    this.id,
    this.cafeId,
    this.genre,
  });

  factory CafeShelf.fromJson(Map<String, dynamic> json) => CafeShelf(
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

List<CafeShelf> cafeshlevesFromJson(String str) =>
    List<CafeShelf>.from(json.decode(str).map((x) => CafeShelf.fromJson(x)));

String cafeShlevesToJson(List<CafeShelf> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
