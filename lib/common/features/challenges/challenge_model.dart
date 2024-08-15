import 'dart:convert';

List<Challenge> challengeFromJson(String str) =>
    List<Challenge>.from(json.decode(str).map((x) => Challenge.fromJson(x)));

String challengeToJson(List<Challenge> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Challenge {
  int? id;
  String? name;
  String? description;
  String? type;
  String? challengeIs;
  int? isOpen;
  DateTime? openDate;
  String? durationType;
  int? durationUnits;
  dynamic image;
  int? points;
  String? rules;
  DateTime? createdAt;
  DateTime? updatedAt;

  Challenge({
    this.id,
    this.name,
    this.description,
    this.type,
    this.challengeIs,
    this.isOpen,
    this.openDate,
    this.durationType,
    this.durationUnits,
    this.image,
    this.points,
    this.rules,
    this.createdAt,
    this.updatedAt,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        challengeIs: json["challenge_is"],
        isOpen: json["is_open"],
        openDate: json["open_date"] == null
            ? null
            : DateTime.parse(json["open_date"]),
        durationType: json["duration_type"],
        durationUnits: json["duration_units"],
        image: json["image"],
        points: json["points"],
        rules: json["rules"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "challenge_is": challengeIs,
        "is_open": isOpen,
        "open_date": openDate?.toIso8601String(),
        "duration_type": durationType,
        "duration_units": durationUnits,
        "image": image,
        "points": points,
        "rules": rules,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
