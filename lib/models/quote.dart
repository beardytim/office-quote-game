class Quote {
  final String id;
  final String quote;
  final String characterId;
  final String character;

  Quote({
    required this.id,
    required this.quote,
    required this.characterId,
    required this.character,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['data']['_id'],
      quote: json['data']['content'],
      characterId: json['data']['character']['_id'],
      character: json['data']['character']['firstname'] +
          " " +
          json['data']['character']['lastname'],
    );
  }
}
