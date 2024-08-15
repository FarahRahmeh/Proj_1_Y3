// To parse this JSON data, do
//
//     final contactUs = contactUsFromJson(jsonString);

import 'dart:convert';

List<ContactUs> contactUsFromJson(String str) =>
    List<ContactUs>.from(json.decode(str).map((x) => ContactUs.fromJson(x)));

String contactUsToJson(List<ContactUs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactUs {
  int? id;
  String? userName;
  String? email;
  String? message;
  String? reply;
  String? repliedBy;
  DateTime? createdAt;

  ContactUs({
    this.id,
    this.userName,
    this.email,
    this.message,
    this.reply,
    this.repliedBy,
    this.createdAt,
  });

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
        id: json["id"],
        userName: json["user_name"],
        email: json["email"],
        message: json["message"],
        reply: json["reply"],
        repliedBy: json["replied_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "email": email,
        "message": message,
        "reply": reply,
        "replied_by": repliedBy,
        "created_at": createdAt?.toIso8601String(),
      };
}
