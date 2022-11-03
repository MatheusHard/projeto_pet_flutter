import 'package:projeto_pet/ui/models/tipo_pet.dart';

class Pet {

  int? id;
  String nome;
  int tipoPet;
  String imagePet;
  String? dataNascimento;
  bool sexo;
  TipoPet? especie;
  int? donoPet;

  Pet({
       this.id, required this.nome, this.donoPet, required this.imagePet,
       required this.tipoPet, this.dataNascimento, required this.sexo,
       this.especie});

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(

    id: json['id']  ?? 0,
    nome: json['nome'] ?? '',
    tipoPet: json['tipoPet'] ?? 0,
    dataNascimento: json['dataNascimento'],
    sexo:  (json['sexo'] == 1) ? true: false,
    donoPet: json['donoPet']  ?? 0,
    imagePet: json['imagePet'] ?? '',
    especie: TipoPet.fromMap(json)
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'tipoPet': tipoPet,
      'dataNascimento': dataNascimento,
      'sexo': sexo,
      'donoPet': donoPet,
      'imagePet': imagePet
    };
  }
}