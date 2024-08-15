import 'dart:convert';

import 'package:booktaste/models/book.dart';

List<ReadLater> readLaterFromJson(String str) =>
    List<ReadLater>.from(json.decode(str).map((x) => ReadLater.fromJson(x)));

String readLaterToJson(List<ReadLater> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadLater {
  String? priority;
  Book? book;

  ReadLater({
    this.priority,
    this.book,
  });

  factory ReadLater.fromJson(Map<String, dynamic> json) => ReadLater(
        priority: json["priority"],
        book: json["0"] == null ? null : Book.fromJson(json["0"]),
      );

  Map<String, dynamic> toJson() => {
        "priority": priority,
        "0": book?.toJson(),
      };
}
