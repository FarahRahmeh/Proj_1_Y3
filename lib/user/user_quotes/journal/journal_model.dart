import 'dart:convert';

List<Journal> journalFromJson(String str) =>
    List<Journal>.from(json.decode(str).map((x) => Journal.fromJson(x)));

String journalToJson(List<Journal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Journal {
  int id;
  String name;
  dynamic bio;
  String imageName;
  String year;
  String createdAt;
  String updatedAt;

  Journal({
    this.id = 0,
    this.name = '',
    this.bio = '',
    this.imageName = '',
    this.year = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        id: json["id"],
        name: json["name"],
        bio: json["bio"].toString(),
        imageName: json["image_name"],
        year: json["year"],
        createdAt: json['created_at'], //DateTime.parse(json["created_at"]),
        updatedAt: json['updated_at'], //DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "image_name": imageName,
        "year": year,
        "created_at": createdAt, // createdAt.toIso8601String(),
        "updated_at": updatedAt // updatedAt.toIso8601String(),
      };
}
