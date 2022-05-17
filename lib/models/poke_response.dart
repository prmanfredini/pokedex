class PokeResponse {
  final String? url;

  PokeResponse({
    required this.url,
  });

  factory PokeResponse.fromJson(Map<String, dynamic> json) {
    return PokeResponse(
      url: json['url'],
    );
  }
}
