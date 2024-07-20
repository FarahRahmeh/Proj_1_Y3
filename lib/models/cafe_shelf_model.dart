import 'dart:convert';

class CafeShelf {
  int? id;
  int? cafeId;
  String? genre;
  String image;

  CafeShelf({this.id, this.cafeId, this.genre, this.image = ""});

  factory CafeShelf.fromJson(Map<String, dynamic> json) => CafeShelf(
        id: json["id"],
        cafeId: json["cafe_id"],
        genre: json["genre"],
        image: json["image"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cafe_id": cafeId,
        "genre": genre,
        "image": image,
      };
}

List<CafeShelf> cafeshlevesFromJson(String str) =>
    List<CafeShelf>.from(json.decode(str).map((x) => CafeShelf.fromJson(x)));

String cafeShlevesToJson(List<CafeShelf> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
