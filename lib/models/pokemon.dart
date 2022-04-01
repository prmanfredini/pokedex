
class PokeUrl {
  final String url;
  PokeUrl({this.url = ''});

  factory PokeUrl.fromJson(Map<String, dynamic> json) {
    return PokeUrl(
      url: json['url'],
    );
  }
}

class NextUrl {
  final String next;
  final String previous;
  NextUrl({this.next = '', this.previous = ''});

  factory NextUrl.fromJson(Map<String, dynamic> json) {
    return NextUrl(
      next: json['next'],
      previous: json['previous'],
    );
  }
}

class Pokemon{
  final String nome;
  final String imagem;
  final String tipo1;
  final String? tipo2;

  Pokemon({this.nome = '', this.imagem = '', this.tipo1 = '', this.tipo2 = '' });
//
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    String tipoOpcional = '';
    List<dynamic> types =  json['types'];
    if (types.length > 1){
      tipoOpcional = types[1]['type']['name'];
    }
    return Pokemon(
      nome: json['name'],
      imagem: json['sprites']['other']['official-artwork']['front_default'],
      tipo1: json['types'][0]['type']['name'],
      tipo2: tipoOpcional,
    );
  }
}