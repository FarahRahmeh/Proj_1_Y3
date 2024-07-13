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
  String type; //novel or not
  String locked;
  int points;

  Book({
    required this.id,
    required this.name,
    required this.writer,
    required this.bookId,
    required this.bookFile,
    required this.cover,
    required this.summary,
    required this.lang,
    required this.pages,
    required this.genre,
    required this.publicationYear,
    required this.readersNum,
    required this.rate,
    required this.avgReadingTime,
    required this.votersNum,
    required this.type,
    required this.locked,
    required this.points,
  });
  static Book empty() => Book(
      id: 0,
      name: "",
      writer: "",
      bookId: "",
      bookFile: "",
      cover: "/",
      summary: "",
      lang: "",
      pages: 0,
      genre: [],
      publicationYear: "",
      readersNum: 0,
      rate: 0,
      avgReadingTime: "",
      votersNum: 0,
      type: "",
      locked: "",
      points: 0);

  factory Book.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      return Book(
          id: json["id"],
          name: json["name"],
          writer: json["writer"],
          avgReadingTime: json['average_read_time'].toString(),
          bookFile: json['book_file'],
          bookId: json["book_id"].toString(),
          cover: json["cover"],
          lang: json["lang"].toString(),
          pages: json["pages"],
          genre: List<String>.from(json["genre"]),
          locked: json["locked?"],
          points: json["points"],
          publicationYear: json["published_at"],
          rate: json["rate"],
          readersNum: json["readers_num"],
          summary: json["summary"],
          type: json["type"],
          votersNum: json["voters_num"]);
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
      };
}
