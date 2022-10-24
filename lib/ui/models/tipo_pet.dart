
class TipoPet {

  int? id;
  String? descricao;


  TipoPet({this.id, this.descricao});

  factory TipoPet.fromMap(Map<String, dynamic> json) => TipoPet(
    id: json['id']  ?? 0,
    descricao: json['descricao'] ?? '',
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'descricao': descricao
    };
  }
}