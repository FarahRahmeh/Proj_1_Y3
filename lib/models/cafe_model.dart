class Cafes {
  int id;
  String name;

  Cafes({
    required this.id,
    required this.name,
  });

  factory Cafes.fromJson(Map<String, dynamic> json) => Cafes(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
