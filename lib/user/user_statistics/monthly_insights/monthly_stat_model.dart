
import 'dart:convert';

List<MonthlyStat> monthlyStatFromJson(String str) => List<MonthlyStat>.from(
    json.decode(str).map((x) => MonthlyStat.fromJson(x)));

String monthlyStatToJson(List<MonthlyStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonthlyStat {
  int? id;
  int? userId;
  int? month;
  String? year;
  int? totalReadPages;
  String? totalReadingTime;
  double? avgDailyReadPages;
  String? avgDailyReadTime;
  int? totalSessions;
  int? totalBooks;
  DateTime? lastActivityDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  MonthlyStat({
    this.id,
    this.userId,
    this.month,
    this.year,
    this.totalReadPages,
    this.totalReadingTime,
    this.avgDailyReadPages,
    this.avgDailyReadTime,
    this.totalSessions,
    this.totalBooks,
    this.lastActivityDate,
    this.createdAt,
    this.updatedAt,
  });

  factory MonthlyStat.fromJson(Map<String, dynamic> json) => MonthlyStat(
        id: json["id"],
        userId: json["user_id"],
        month: json["month"],
        year: json["year"],
        totalReadPages: json["total_read_pages"],
        totalReadingTime: json["total_reading_time"],
        avgDailyReadPages: json["avg_daily_read_pages"]?.toDouble(),
        avgDailyReadTime: json["avg_daily_read_time"],
        totalSessions: json["total_sessions"],
        totalBooks: json["total_books"],
        lastActivityDate: json["last_activity_date"] == null
            ? null
            : DateTime.parse(json["last_activity_date"]),
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
        "month": month,
        "year": year,
        "total_read_pages": totalReadPages,
        "total_reading_time": totalReadingTime,
        "avg_daily_read_pages": avgDailyReadPages,
        "avg_daily_read_time": avgDailyReadTime,
        "total_sessions": totalSessions,
        "total_books": totalBooks,
        "last_activity_date":
            "${lastActivityDate!.year.toString().padLeft(4, '0')}-${lastActivityDate!.month.toString().padLeft(2, '0')}-${lastActivityDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
