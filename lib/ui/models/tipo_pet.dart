
class TipoPet {

  int? id;
  String? descricao;


  TipoPet({this.id, this.descricao});



  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'descricao': descricao
    };
  }
  TipoPet.fromMap(Map mapa){

    this.descricao = mapa['descricao'];
    this.id = mapa['id'];
  }
}