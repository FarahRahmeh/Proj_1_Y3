class Category {
  String? genre;
  // final variable = do NOT want to update it
  String? cafeId;

  String? id;

  Category({
    this.id,
    this.cafeId,
    this.genre,
  });

  static Category empty() => Category(genre: '', id: '', cafeId: '');

  Map<String, dynamic> toJson() {
    return {
      'genre': genre,
      'cafe_id': cafeId,
      'id': id,
    };
  }

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData.isNotEmpty) {
      return Category(
        genre: jsonData['genre'] ?? '',
        cafeId: jsonData['cafe_id'] ?? '',
        id: jsonData['id'] ?? '',
      );
    } else {
      return Category.empty();
    }
  }
}
