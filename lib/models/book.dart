import 'dart:convert';

class Book {
  int id;
  String bookId;
  String bookFile;
  String name;
  String writer;
  String cover;
  String summary;
  String lang;
  int pages;
  List<String> genre;
  String publicationYear;
  int readersNum;
  double rate;
  String avgReadingTime;
  int votersNum;
  String? type;
  String? locked;
  int points;
  final String? updatedAt;
  final String? createdAt;

  Book({
    this.id = 0,
    this.bookId = "",
    this.bookFile = "",
    this.name = "",
    this.writer = "",
    this.cover = "/",
    this.summary = "",
    this.lang = "",
    this.pages = 0,
    this.genre = const [],
    this.publicationYear = "",
    this.readersNum = 0,
    this.rate = 0.0,
    this.avgReadingTime = "",
    this.votersNum = 0,
    this.type = '0',
    this.locked = '0',
    this.points = 0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  static Book empty() => Book();

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      writer: json["writer"] ?? "",
      avgReadingTime: json['avg_read_time']?.toString() ?? "",
      bookFile: json['book'] ?? "",
      bookId: json["book_id"]?.toString() ?? "",
      cover: json["cover"] ?? "",
      lang: json["lang"]?.toString() ?? "",
      pages: json["pages_num"] ?? 0,
      genre: List<String>.from(json["genre"] ?? []),
      locked: json["is_locked"]?.toString() ?? '0',
      points: json["points"] ?? 0,
      publicationYear: json["published_at"]?.toString() ?? "",
      rate: json["stars"]?.toDouble() ?? 0.0,
      readersNum: json["num_of_readers"] ?? 0,
      summary: json["summary"] ?? "",
      type: json["is_novel"]?.toString() ?? '0',
      votersNum: json["num_of_voters"] ?? 0,
      updatedAt: json['updated_at'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "writer": writer,
        "avg_read_time": avgReadingTime,
        "book": bookFile,
        "book_id": bookId,
        "cover": cover,
        "lang": lang,
        "pages_num": pages,
        "genre": genre,
        "is_locked": locked,
        "points": points,
        "published_at": publicationYear,
        "stars": rate,
        "summary": summary,
        "is_novel": type,
        "num_of_voters": votersNum,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));