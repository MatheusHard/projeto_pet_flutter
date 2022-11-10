
class Vacina {

  int? id;
  String dataCadastro;
  String dataAplicacao;
  String nomeVacina;
  int petId;

  Vacina({this.id, required this.nomeVacina, required this.dataCadastro, required this.petId, required this.dataAplicacao});

  factory Vacina.fromMap(Map<String, dynamic> json) => Vacina(

      id: json['id']  ?? 0,
      nomeVacina: json['nomeVacina'] ?? '',
      dataCadastro: json['dataCadastro'] ?? '',
      dataAplicacao: json['dataAplicacao'] ?? '',
      petId: json['petId'],

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nomeVacina': nomeVacina,
      'dataCadastro': dataCadastro,
      'dataAplicacao': dataAplicacao,
      'petId': petId
    };
  }
}