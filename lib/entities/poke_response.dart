class PokeResponse {
  final String? url;

  PokeResponse({
    required this.url,
  });

  factory PokeResponse.fromJson(Map<String, dynamic> json) => PokeResponse(
        url: json['url'],
      );
}
