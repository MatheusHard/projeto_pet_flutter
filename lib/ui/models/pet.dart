
import 'package:projeto_pet/ui/models/tipo_pet.dart';

class Pet {

  int? id;
  String nome;
  int tipoPet;
  int? idade;
  String? dataNascimento;
  bool sexo;
  TipoPet? especie;

  Pet({
       this.id, required this.nome, this.idade,
       required this.tipoPet, this.dataNascimento, required this.sexo,
       this.especie});

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(

    id: json['id']  ?? 0,
    nome: json['nome'] ?? '',
      tipoPet: json['tipoPet'],
    dataNascimento: json['dataNascimento'],
    sexo:  (json['sexo'] == 1) ? true: false,
    especie: TipoPet.fromMap(json)
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'tipoPet': tipoPet,
      'dataNascimento': dataNascimento,
      'sexo': sexo
    };
  }
}