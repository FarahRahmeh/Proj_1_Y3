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
  List<dynamic> genre;
  String publicationYear;
  int readersNum;
  int rate;
  String avgReadingTime;
  int votersNum;
  String type; // novel or not
  String locked;
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
    this.rate = 0,
    this.avgReadingTime = "",
    this.votersNum = 0,
    this.type = "",
    this.locked = "",
    this.points = 0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  static Book empty() => Book();

  factory Book.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Book(
          id: json["id"] ?? 0,
          name: json["name"] ?? "",
          writer: json["writer"] ?? "",
          avgReadingTime: json['average_read_time'].toString(),
          bookFile: json['book_file'] ?? "",
          bookId: json["book_id"].toString(),
          cover: json["cover"] ?? "",
          lang: json["lang"].toString(),
          pages: json["pages"] ?? 0,
          genre: List<String>.from(json["genre"] ?? []),
          locked: json["locked?"] ?? "",
          points: json["points"] ?? 0,
          publicationYear: json["published_at"] ?? "",
          rate: json["rate"] ?? 0,
          readersNum: json["readers_num"] ?? 0,
          summary: json["summary"] ?? "",
          type: json["type"] ?? "",
          votersNum: json["voters_num"] ?? 0,
          updatedAt: json['updated_at'] ?? "",
          createdAt: json['created_at'] ?? "");
    } else {
      return Book.empty();
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "writer": writer,
        "average_read_time": avgReadingTime,
        "book_file": bookFile,
        "book_id": bookId,
        "cover": cover,
        "lang": lang,
        "pages": pages,
        "genre": genre,
        "locked?": locked,
        "points": points,
        "published_at": publicationYear,
        "rate": rate,
        "summary": summary,
        "type": type,
        "voters_num": votersNum,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
