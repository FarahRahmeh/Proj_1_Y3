import 'dart:convert';

class Quote {
  int quoteId;
  String quote;
  String sourceId;
  String bookTitle;
  String author;
  int page;
  String thoughts;
  String image;
  String fav;

  Quote({
    this.quoteId = 0,
    this.quote = '',
    this.sourceId = '',
    this.bookTitle = '',
    this.author = '',
    this.page = 0,
    this.thoughts = '',
    this.image = '',
    this.fav = '',
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quoteId: json['quote_id'],
      quote: json['quote'] ?? '',
      sourceId: json['source_id'] ?? '',
      bookTitle: json['name'] ?? ' Unknown',
      author: json['writer'] ?? 'unkown',
      page: json['page_num'] ?? 0,
      thoughts: json['my_thoughts'] ?? '',
      image: json['image'] ?? '',
      fav: json['in_fav'].toString() ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quote_id': quoteId,
      'quote': quote,
      'source_id': sourceId, //sourceId.isEmpty ? null :
      'name': bookTitle, //bookTitle.isEmpty ? null :
      'writer': author, //author.isEmpty ? null :
      'page_num': page, // page == 0 ? null :
      'my_thoughts': thoughts, //thoughts.isEmpty ? null :
      'image': image, //image.isEmpty ? null :
      'in_fav': fav, //fav.isEmpty ? null :
    };
  }
}

List<Quote> QuoteFromJson(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String QuoteToJson(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
