// import 'dart:convert';

// import 'package:booktaste/models/book.dart';

// List<UserBookRequest> bookRequestFromJson(String str) => List<UserBookRequest>.from(
//     json.decode(str).map((x) => UserBookRequest.fromJson(x)));

// String bookRequestToJson(List<UserBookRequest> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class UserBookRequest {
//   String? requestStatus;
//   DateTime? requestDate;
//   Book? book;

//   UserBookRequest({
//     this.requestStatus,
//     this.requestDate,
//     this.book,
//   });

//   factory UserBookRequest.fromJson(Map<String, dynamic> json) => UserBookRequest(
//         requestStatus: json["request_status"],
//         requestDate: json["request_date"] == null
//             ? null
//             : DateTime.parse(json["request_date"]),
//         book: json["book"] == null ? null : Book.fromJson(json["book"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "request_status": requestStatus,
//         "request_date": requestDate?.toIso8601String(),
//         "book": book?.toJson(),
//       };
// }
// import 'package:booktaste/models/book.dart';

// class BookRequest {
//   int? id;
//   BookRequest(this.id);
// }

// class ApprovedRequest extends BookRequest {
//   String? requestStatus;
//   DateTime? requestDate;
//   Book? book;

//   ApprovedRequest({
//     int? id,
//     this.requestStatus,
//     this.requestDate,
//     this.book,
//   }) : super(id);
// }

// class DeletedRequest extends BookRequest {
//   int? bookId;
//   int? userId;
//   String? status;
//   DateTime? statusChangeDate;
//   String? bookName;
//   String? author;
//   int? pagesNum;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   DeletedRequest({
//     int? id,
//     this.bookId,
//     this.userId,
//     this.status,
//     this.statusChangeDate,
//     this.bookName,
//     this.author,
//     this.pagesNum,
//     this.createdAt,
//     this.updatedAt,
//   }) : super(id);
// }

// BookRequest factoryBRfromJson(Map<String, dynamic> json) {
//   if (json.containsKey('request_status')) {
//     return ApprovedRequest(
//       id: json['id'],
//       requestStatus: json['request_status'],
//       requestDate: json["request_date"] == null
//           ? null
//           : DateTime.parse(json["request_date"]),
//       book: json["book"] == null ? null : Book.fromJson(json["book"]),
//     );
//   } else if (json.containsKey('status')) {
//     return DeletedRequest(
//       id: json['id'],
//       bookId: json['book_id'],
//       userId: json['user_id'],
//       status: json['status'],
//       statusChangeDate: json["status_change_date"] == null
//           ? null
//           : DateTime.parse(json["status_change_date"]),
//       bookName: json['book_name'],
//       author: json['author'],
//       pagesNum: json['pages_num'],
//       createdAt: json["created_at"] == null
//           ? null
//           : DateTime.parse(json["created_at"]),
//       updatedAt: json["updated_at"] == null
//           ? null
//           : DateTime.parse(json["updated_at"]),
//     );
//   }
//   // handle other cases or throw an exception
//   throw Exception('Unknown request type');
// }
import 'dart:convert';
import 'package:booktaste/models/book.dart';

// Function to convert JSON string to a list of UserBookRequest
List<UserBookRequest> bookRequestFromJson(String str) =>
    List<UserBookRequest>.from(
        json.decode(str).map((x) => UserBookRequest.fromJson(x)));

// Function to convert a list of UserBookRequest to JSON string
String bookRequestToJson(List<UserBookRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserBookRequest {
  int? id;
  String? requestStatus;
  DateTime? requestDate;
  Book? book;

  UserBookRequest({
    this.id,
    this.requestStatus,
    this.requestDate,
    this.book,
  });

  factory UserBookRequest.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('request_status')) {
      return ApprovedRequest.fromJson(json);
    } else if (json.containsKey('status')) {
      return DeletedRequest.fromJson(json);
    }
    throw Exception('Unknown request type');
  }

  Map<String, dynamic> toJson() {
    if (this is ApprovedRequest) {
      return (this as ApprovedRequest).toJson();
    } else if (this is DeletedRequest) {
      return (this as DeletedRequest).toJson();
    }
    throw Exception('Unknown request type');
  }
}

class ApprovedRequest extends UserBookRequest {
  ApprovedRequest({
    int? id,
    String? requestStatus,
    DateTime? requestDate,
    Book? book,
  }) : super(
            id: id,
            requestStatus: requestStatus,
            requestDate: requestDate,
            book: book);

  factory ApprovedRequest.fromJson(Map<String, dynamic> json) =>
      ApprovedRequest(
        id: json['id'],
        requestStatus: json['request_status'],
        requestDate: json["request_date"] == null
            ? null
            : DateTime.parse(json["request_date"]),
        book: json["book"] == null ? null : Book.fromJson(json["book"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "request_status": requestStatus,
        "request_date": requestDate?.toIso8601String(),
        "book": book?.toJson(),
      };
}

class DeletedRequest extends UserBookRequest {
  int? bookId;
  int? userId;
  String? status;
  DateTime? statusChangeDate;
  String? bookName;
  String? author;
  int? pagesNum;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeletedRequest({
    int? id,
    this.bookId,
    this.userId,
    this.status,
    this.statusChangeDate,
    this.bookName,
    this.author,
    this.pagesNum,
    this.createdAt,
    this.updatedAt,
  }) : super(id: id);

  factory DeletedRequest.fromJson(Map<String, dynamic> json) => DeletedRequest(
        id: json['id'],
        bookId: json['book_id'],
        userId: json['user_id'],
        status: json['status'],
        statusChangeDate: json["status_change_date"] == null
            ? null
            : DateTime.parse(json["status_change_date"]),
        bookName: json['book_name'],
        author: json['author'],
        pagesNum: json['pages_num'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "user_id": userId,
        "status": status,
        "status_change_date": statusChangeDate?.toIso8601String(),
        "book_name": bookName,
        "author": author,
        "pages_num": pagesNum,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
