import 'dart:convert';

List<AllBooks> allBooksFromJson(String str) =>
    List<AllBooks>.from(json.decode(str).map((x) => AllBooks.fromJson(x)));

String allBooksToJson(List<AllBooks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBooks {
  int id;
  String name;
  String cover;
  String writer;
  double stars;

  AllBooks({
    required this.id,
    required this.name,
    required this.cover,
    required this.writer,
    required this.stars,
  });

  factory AllBooks.fromJson(Map<String, dynamic> json) => AllBooks(
        id: json["id"],
        name: json["name"],
        cover: json["cover"],
        writer: json["writer"],
        stars: json["stars"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
        "writer": writer,
        "stars": stars,
      };
}
