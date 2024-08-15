import 'dart:convert';

List<DailyStat> dailyStatFromJson(String str) =>
    List<DailyStat>.from(json.decode(str).map((x) => DailyStat.fromJson(x)));

String dailyStatToJson(List<DailyStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyStat {
  int? id;
  int? userId;
  DateTime? date;
  int? totalReadPages;
  String? totalReadingTime;
  int? numOfSessions;
  DateTime? createdAt;
  DateTime? updatedAt;

  DailyStat({
    this.id,
    this.userId,
    this.date,
    this.totalReadPages,
    this.totalReadingTime,
    this.numOfSessions,
    this.createdAt,
    this.updatedAt,
  });

  factory DailyStat.fromJson(Map<String, dynamic> json) => DailyStat(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        totalReadPages: json["total_read_pages"],
        totalReadingTime: json["total_reading_time"],
        numOfSessions: json["num_of_sessions"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "total_read_pages": totalReadPages,
        "total_reading_time": totalReadingTime,
        "num_of_sessions": numOfSessions,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
