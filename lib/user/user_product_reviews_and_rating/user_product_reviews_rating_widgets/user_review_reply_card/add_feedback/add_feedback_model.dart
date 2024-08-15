// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

FeedbackP feedbackFromJson(String str) => FeedbackP.fromJson(json.decode(str));

String feedbackToJson(FeedbackP data) => json.encode(data.toJson());

class FeedbackP {
    int bookId;
    int userId;
    String feedback;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    FeedbackP({
        required this.bookId,
        required this.userId,
        required this.feedback,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory FeedbackP.fromJson(Map<String, dynamic> json) => FeedbackP(
        bookId: json["book_id"],
        userId: json["user_id"],
        feedback: json["feedback"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "user_id": userId,
        "feedback": feedback,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}


List<FeedbackG> feedbackgFromJson(String str) => List<FeedbackG>.from(json.decode(str).map((x) => FeedbackG.fromJson(x)));

String feedbackgToJson(List<FeedbackG> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackG {
    int id;
    String userName;
    String feedback;
    int likes;
    int dislikes;
    int adminsLikes;
    DateTime createdAt;

    FeedbackG({
        required this.id,
        required this.userName,
        required this.feedback,
        required this.likes,
        required this.dislikes,
        required this.adminsLikes,
        required this.createdAt,
    });

    factory FeedbackG.fromJson(Map<String, dynamic> json) => FeedbackG(
        id: json["id"],
        userName: json["user_name"],
        feedback: json["feedback"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        adminsLikes: json["admins_likes"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "feedback": feedback,
        "likes": likes,
        "dislikes": dislikes,
        "admins_likes": adminsLikes,
        "created_at": createdAt.toIso8601String(),
    };
}
