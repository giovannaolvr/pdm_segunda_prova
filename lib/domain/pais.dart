// QUESTÃO 2) 

class Pais {
  static const String paisTable = "paises_table";
  static const String idColuna = "id";
  static const String nomeColuna = "nome";
  static const String capitalColuna = "capital";
  static const String continenteColuna = "continente";
  static const String linguaColuna = "linguaOficial";
  static const String populacaoColuna = "populacao";
  static const String moedaColuna = "moeda";

  int id = 0;
  String nome = '';
  String capital = '';
  String continente = '';
  String linguaOficial = '';
  double populacao = 0;
  String moeda = '';

  // Construtor sem id
  Pais(this.nome, this.capital, this.continente, this.linguaOficial,
      this.populacao, this.moeda);

  // Construtor com id
  Pais.withId(this.id, this.nome, this.capital, this.continente,
      this.linguaOficial, this.populacao, this.moeda);

  Pais.fromMap(Map map) {
    id = map[idColuna];
    nome = map[nomeColuna];
    capital = map[capitalColuna];
    continente = map[continenteColuna];
    linguaOficial = map[linguaColuna];
    populacao = map[populacaoColuna];
    moeda = map[moedaColuna];
  }

  Map<String, dynamic> toMap() {
    return {
      nomeColuna: nome,
      capitalColuna: capital,
      continenteColuna: continente,
      linguaColuna: linguaOficial,
      populacaoColuna: populacao,
      moedaColuna: moeda
    };
  }

  @override
  String toString() {
    return 'Pais{nome: $nome, capital: $capital, continente: $continente, lingua oficial: $linguaOficial, populacao: $populacao, moeda: $moeda}';
  }
}
