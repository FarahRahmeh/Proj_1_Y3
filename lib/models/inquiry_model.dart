import 'dart:convert';

List<Inquiry> inquiryFromJson(String str) =>
    List<Inquiry>.from(json.decode(str).map((x) => Inquiry.fromJson(x)));

String inquiryToJson(List<Inquiry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Inquiry {
  int? id;
  String? userName;
  String? inquiry;
  dynamic reply;
  dynamic repliedBy;
  DateTime? createdAt;

  Inquiry({
    this.id,
    this.userName,
    this.inquiry,
    this.reply,
    this.repliedBy,
    this.createdAt,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) => Inquiry(
        id: json["id"],
        userName: json["user_name"],
        inquiry: json["inquiry"],
        reply: json["reply"],
        repliedBy: json["replied_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "inquiry": inquiry,
        "reply": reply,
        "replied_by": repliedBy,
        "created_at": createdAt?.toIso8601String(),
      };
}
