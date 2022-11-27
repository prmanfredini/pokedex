class PokeUrl {
  final String url;

  PokeUrl({
    required this.url,
  });

  factory PokeUrl.fromJson(Map<String, dynamic> json) => PokeUrl(
        url: json['url'],
      );
}
