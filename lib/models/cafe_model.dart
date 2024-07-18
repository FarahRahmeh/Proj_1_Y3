class Cafe {
  int id;
  String name;
  String bio;
  String image;

  Cafe({
    required this.id,
    required this.name,
    required this.bio,
    required this.image,
  });

  factory Cafe.fromJson(Map<String, dynamic> json) => Cafe(
        id: json["id"],
        name: json["name"],
        bio: json["cafe_bio"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cafe_bio": bio,
        "image": image,
      };
}
