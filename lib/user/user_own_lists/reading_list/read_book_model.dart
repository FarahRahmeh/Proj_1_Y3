import 'dart:convert';

import 'package:booktaste/models/book.dart';

List<ReadBook> readBookFromJson(String str) =>
    List<ReadBook>.from(json.decode(str).map((x) => ReadBook.fromJson(x)));

String readBookToJson(List<ReadBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReadBook {
  int? currentPage;
  String? readTimeSoFar;
  String? percentage;
  Book? book;

  ReadBook({
    this.currentPage,
    this.readTimeSoFar,
    this.percentage,
    this.book,
  });

  factory ReadBook.fromJson(Map<String, dynamic> json) => ReadBook(
        currentPage: json["current_page"],
        readTimeSoFar: json["read_time_so_far"],
        percentage: json["percentage"],
        book: json["0"] == null ? null : Book.fromJson(json["0"]),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "read_time_so_far": readTimeSoFar,
        "percentage": percentage,
        "0": book?.toJson(),
      };
}
