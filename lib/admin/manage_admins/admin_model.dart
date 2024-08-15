
import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
    int? id;
    String? name;
    String? email;
    DateTime? emailVerifiedAt;
    String? role;
    DateTime? createdAt;
    DateTime? updatedAt;

    Admin({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.role,
        this.createdAt,
        this.updatedAt,
    });

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        role: json["role"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
