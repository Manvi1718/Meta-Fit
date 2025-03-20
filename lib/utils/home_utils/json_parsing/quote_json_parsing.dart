// Model class for Quote
class RandomQuote {
  int id;
  String quote;
  String author;

  RandomQuote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory RandomQuote.fromJson(Map<String, dynamic> json) {
    return RandomQuote(
      id: json["id"],
      quote: json["quote"],
      author: json["author"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quote": quote,
      "author": author,
    };
  }
}
