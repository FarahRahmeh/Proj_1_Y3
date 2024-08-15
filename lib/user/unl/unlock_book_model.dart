// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UnlockBook unlockFromJson(String str) => UnlockBook.fromJson(json.decode(str));

String unlockToJson(UnlockBook data) => json.encode(data.toJson());

class UnlockBook {
    int id;
    String bookId;
    String book;
    String name;
    String writer;
    String cover;
    String summary;
    String lang;
    int pagesNum;
    List<String> genre;
    String publishedAt;
    int numOfReaders;
    int stars;
    dynamic avgReadTime;
    int numOfVoters;
    int isNovel;
    int isLocked;
    dynamic points;
    DateTime createdAt;

    UnlockBook({
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

    factory UnlockBook.fromJson(Map<String, dynamic> json) => UnlockBook(
        id: json["id"],
        bookId: json["book_id"],
        book: json["book"],
        name: json["name"],
        writer: json["writer"],
        cover: json["cover"],
        summary: json["summary"],
        lang: json["lang"],
        pagesNum: json["pages_num"],
        genre: List<String>.from(json["genre"].map((x) => x)),
        publishedAt: json["published_at"],
        numOfReaders: json["num_of_readers"],
        stars: json["stars"],
        avgReadTime: json["avg_read_time"],
        numOfVoters: json["num_of_voters"],
        isNovel: json["is_novel"],
        isLocked: json["is_locked"],
        points: json["points"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "book": book,
        "name": name,
        "writer": writer,
        "cover": cover,
        "summary": summary,
        "lang": lang,
        "pages_num": pagesNum,
        "genre": List<dynamic>.from(genre.map((x) => x)),
        "published_at": publishedAt,
        "num_of_readers": numOfReaders,
        "stars": stars,
        "avg_read_time": avgReadTime,
        "num_of_voters": numOfVoters,
        "is_novel": isNovel,
        "is_locked": isLocked,
        "points": points,
        "created_at": createdAt.toIso8601String(),
    };
}
