

class Especie {

  int? id;
  String? descricao;

  Especie({this.id, this.descricao});

  factory Especie.fromMap(Map<String, dynamic> json) => Especie(
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