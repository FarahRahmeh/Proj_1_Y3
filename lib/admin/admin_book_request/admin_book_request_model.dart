import 'dart:convert';

import '../../models/book.dart';

List<AdminBookRequest> adminBookRequestFromJson(String str) =>
    List<AdminBookRequest>.from(
        json.decode(str).map((x) => AdminBookRequest.fromJson(x)));

String adminBookRequestToJson(List<AdminBookRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminBookRequest {
  int? id;
  String? requestOwner;
  String? requestOwnerEmail;
  DateTime? requestDate;
  Book? book;

  AdminBookRequest({
    this.id,
    this.requestOwner,
    this.requestOwnerEmail,
    this.requestDate,
    this.book,
  });

  factory AdminBookRequest.fromJson(Map<String, dynamic> json) =>
      AdminBookRequest(
        id: json["id"],
        requestOwner: json["request_owner"],
        requestOwnerEmail: json["request_owner_email"],
        requestDate: json["request_date"] == null
            ? null
            : DateTime.parse(json["request_date"]),
        book: json["book"] == null ? null : Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "request_owner": requestOwner,
        "request_owner_email": requestOwnerEmail,
        "request_date": requestDate?.toIso8601String(),
        "book": book?.toJson(),
      };
}
