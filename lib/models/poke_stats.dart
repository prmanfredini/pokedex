
class PokeStats{
  final int base;
  final String name;

  PokeStats({required this.base, required this.name});

  factory PokeStats.fromJson(Map<String, dynamic> json) {
    return PokeStats(
        base: json['base_stat'],
        name: json['stat']['name']);
  }
}