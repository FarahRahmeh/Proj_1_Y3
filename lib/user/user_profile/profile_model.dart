import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int? id;
  String? name;
  String? email;
  String? profilePhoto;
  int? myPoints;
  List<FavGenre>? favGenres;
  int? achievementId;
  String? achievementName;
  String? achievementMessage;

  Profile({
    this.id,
    this.name,
    this.email,
    this.profilePhoto,
    this.myPoints,
    this.favGenres,
    this.achievementId,
    this.achievementName,
    this.achievementMessage,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profilePhoto: json["profile_photo"],
        myPoints: json["my_points"],
        favGenres: json["fav_genres"] == null
            ? []
            : List<FavGenre>.from(
                (json["fav_genres"] ?? []).map((x) => FavGenre.fromJson(x))),
        achievementId: json["achievement_id"],
        achievementName: json["achievement_name"],
        achievementMessage: json["achievement_message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_photo": profilePhoto,
        "my_points": myPoints,
        "fav_genres": favGenres == null
            ? []
            : List<dynamic>.from(favGenres!.map((x) => x.toJson())),
        "achievement_id": achievementId,
        "achievement_name": achievementName,
        "achievement_message": achievementMessage,
      };
}

class FavGenre {
  String? genre;
  dynamic lastInteractWithAt;

  FavGenre({
    this.genre,
    this.lastInteractWithAt,
  });

  factory FavGenre.fromJson(Map<String, dynamic> json) => FavGenre(
        genre: json["genre"],
        lastInteractWithAt: json["last_interact_with_at"],
      );

  Map<String, dynamic> toJson() => {
        "genre": genre,
        "last_interact_with_at": lastInteractWithAt,
      };
}
