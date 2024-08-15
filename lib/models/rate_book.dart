import 'dart:convert';

List<RateBook> rateBookFromJson(String str) =>
    List<RateBook>.from(json.decode(str).map((x) => RateBook.fromJson(x)));

String rateBookToJson(List<RateBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RateBook {
  int? id;
  String? bookId;
  String? bookFile;
  String? name;
  String? writer;
  String? cover;
  String? summary;
  String? lang;
  int? pages;
  List<String>? genre;
  String? publishedAt;
  int? readersNum;
  double? stars;
  String? averageReadTime;
  int? votersNum;
  int? type;
  int? locked;
  int? points;
  DateTime? createdAt;

  RateBook({
    this.id,
    this.bookId,
    this.bookFile,
    this.name,
    this.writer,
    this.cover,
    this.summary,
    this.lang,
    this.pages,
    this.genre,
    this.publishedAt,
    this.readersNum,
    this.stars = 0.0,
    this.averageReadTime,
    this.votersNum,
    this.type,
    this.locked,
    this.points,
    this.createdAt,
  });

  factory RateBook.fromJson(Map<String, dynamic> json) => RateBook(
        id: json["id"],
        bookId: json["book_id"],
        bookFile: json["book_file"],
        name: json["name"],
        writer: json["writer"],
        cover: json["cover"],
        summary: json["summary"],
        lang: json["lang"],
        pages: json["pages"],
        genre: json["genre"] == null
            ? []
            : List<String>.from(json["genre"]!.map((x) => x)),
        publishedAt: json["published_at"],
        readersNum: json["readers_num"],
        stars: json["stars"]?.toDouble() ?? 0.0,
        averageReadTime: json["average_read_time"],
        votersNum: json["voters_num"],
        type: json["type"],
        locked: json["locked?"],
        points: json["points"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "book_file": bookFile,
        "name": name,
        "writer": writer,
        "cover": cover,
        "summary": summary,
        "lang": lang,
        "pages": pages,
        "genre": genre == null ? [] : List<dynamic>.from(genre!.map((x) => x)),
        "published_at": publishedAt,
        "readers_num": readersNum,
        "stars": stars,
        "average_read_time": averageReadTime,
        "voters_num": votersNum,
        "type": type,
        "locked?": locked,
        "points": points,
        "created_at": createdAt?.toIso8601String(),
      };
}
