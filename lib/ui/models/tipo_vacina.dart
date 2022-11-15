
class TipoVacina {

  int? id;
  String dataCadastro;
  String nomeVacina;
  String nomeFantasia;


  TipoVacina({this.id, required this.nomeVacina,  required this.nomeFantasia, required this.dataCadastro});

  factory TipoVacina.fromMap(Map<String, dynamic> json) => TipoVacina(

    id: json['id']  ?? 0,
    nomeVacina: json['nomeVacina'] ?? '',
    dataCadastro: json['dataCadastro'] ?? '',
    nomeFantasia: json['nomeFantasia'] ?? ''

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nomeVacina': nomeVacina,
      'nomeFantasia': nomeFantasia,
      'dataCadastro': dataCadastro

    };
  }
}