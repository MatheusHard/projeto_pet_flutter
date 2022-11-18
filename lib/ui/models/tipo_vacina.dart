
class TipoVacina {

  int? id;
  String dataCadastro;
  String nomeVacina;


  TipoVacina({this.id, required this.nomeVacina, required this.dataCadastro});

  factory TipoVacina.fromMap(Map<String, dynamic> json) => TipoVacina(

    id: json['id']  ?? 0,
    nomeVacina: json['nomeVacina'] ?? '',
    dataCadastro: json['dataCadastro'] ?? ''

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nomeVacina': nomeVacina,
      'dataCadastro': dataCadastro

    };
  }
}