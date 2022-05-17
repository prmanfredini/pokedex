class PokeUrl {
  final String url;

  PokeUrl({
    required this.url,
  });

  factory PokeUrl.fromJson(Map<String, dynamic> json) {
    return PokeUrl(
      url: json['url'],
    );
  }
}