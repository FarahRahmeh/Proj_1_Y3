
import 'dart:convert';

import 'package:booktaste/models/user_model.dart';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
    String? token;
    User? user;

    Auth({
        this.token,
        this.user,
    });

    factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
    };
}

