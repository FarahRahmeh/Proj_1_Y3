class BookModel {
  String? bookFile;
  String? id;
  String? name;
  String? author;
  String? summary;
  int? pages;
  bool? isNovel;
  bool? isLocked;
  int? points;
  bool? approved;
  String? publicationYear;
  String? cover;

  BookModel(
      {this.id,
      this.approved,
      this.author,
      this.bookFile,
      this.cover,
      this.isLocked,
      this.isNovel,
      this.name,
      this.pages,
      this.points,
      this.publicationYear,
      this.summary});

  static BookModel empty() => BookModel(
      bookFile: '',
      author: '',
      cover: '',
      id: '',
      approved: false,
      isLocked: false,
      isNovel: false,
      name: '',
      pages: 0,
      points: 0,
      publicationYear: '',
      summary: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book': bookFile,
      'name': name,
      'writer': author,
      'cover': cover,
      'summary': summary,
      'pages_num': pages,
      'published_at': publicationYear,
      'points': points,
      'is_novel': isNovel,
      'is_locked': isLocked,
      'approved': approved,
    };
  }

  factory BookModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData.isNotEmpty) {
      return BookModel(
        id: jsonData['id'] ?? '',
        name: jsonData['name'] ?? '',
        bookFile: jsonData['book'] ?? '',
        cover: jsonData['cover'] ?? '',
        summary: jsonData['summary'] ?? '',
        author: jsonData['writer'] ?? '',
        pages: jsonData['pages_num'] ?? 0,
      );
    } else {
      return BookModel.empty();
    }
  }
}
