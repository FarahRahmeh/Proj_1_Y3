import 'dart:convert';

List<PopularBook> popularBookFromJson(String str) => List<PopularBook>.from(
    json.decode(str).map((x) => PopularBook.fromJson(x)));

String popularBookToJson(List<PopularBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularBook {
  int? id;
  String? bookId;
  String? name;
  String? author;
  String? cover;
  String? language;
  double? stars;
  double? readPercent;

  PopularBook({
    this.id,
    this.bookId,
    this.name,
    this.author,
    this.cover,
    this.language,
    this.stars,
    this.readPercent,
  });

  factory PopularBook.fromJson(Map<String, dynamic> json) => PopularBook(
        id: json["id"],
        bookId: json["book_id"],
        name: json["name"],
        author: json["writer"],
        cover: json["cover"],
        language: json["language"],
        stars: json["stars"].toDouble(),
        readPercent: json["read_percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "name": name,
        "writer": author,
        "cover": cover,
        "language": language,
        "stars": stars,
        "read_percent": readPercent,
      };
}
