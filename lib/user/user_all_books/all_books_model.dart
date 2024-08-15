import 'dart:convert';

List<AllBooks> allBooksFromJson(String str) =>
    List<AllBooks>.from(json.decode(str).map((x) => AllBooks.fromJson(x)));

String allBooksToJson(List<AllBooks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBooks {
 int id;
    String? bookId;
    String? book;
    String name;
    String writer;
    String? cover;
    String? summary;
    String ?lang;
    int ?pagesNum;
    List<dynamic> genre;
    String ?publishedAt;
    int? numOfReaders;
    double? stars;
    String? avgReadTime;
    int? numOfVoters;
    int? isNovel;
    int? isLocked;
    int? points;
    DateTime? createdAt;

  AllBooks({
     required this.id,
        required this.bookId,
        required this.book,
        required this.name,
        required this.writer,
        required this.cover,
        required this.summary,
        required this.lang,
        required this.pagesNum,
        required this.genre,
        required this.publishedAt,
        required this.numOfReaders,
        required this.stars,
        required this.avgReadTime,
        required this.numOfVoters,
        required this.isNovel,
        required this.isLocked,
        required this.points,
        required this.createdAt,
  });

  factory AllBooks.fromJson(Map<String, dynamic> json) => AllBooks(
        id: json["id"],
        name: json["name"],
        cover: json["cover"],
        writer: json["writer"],
        stars: json["stars"].toDouble(),
        avgReadTime: json["avgReadTime"],
        book: json["book"],
        bookId: json["bookId"],
        createdAt: json["createdAt"],
        genre: json["genre"],
        isLocked: json["isLocked"],
        isNovel: json["isNovel"],
        lang: json["lang"],
        numOfReaders: json["numOfReaders"],
        numOfVoters: json["numOfVoters"],
        pagesNum: json["pagesNum"],
        points: json["points"],
        publishedAt: json["publishedAt"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
        "writer": writer,
        "stars": stars,
        "genere" : genre,
        "bookId" : bookId,
      };
}
