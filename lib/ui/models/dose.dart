
class Dose {

  int? id;
  String? descricao;
  String? dose;

  Dose({this.id, required this.descricao, required this.dose});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'descricao': descricao,
      'dose': dose
    };
  }
  Dose.fromMap(Map mapa){

    descricao = mapa['descricao'];
    id = mapa['id'];
    dose = mapa['dose'];
  }
}