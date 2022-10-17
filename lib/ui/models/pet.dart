import 'package:projeto_pet/ui/models/tipo_pet.dart';

class Pet {

  int id;
  String? nome;
  int especiePet;
  int? idade;

  Pet({required this.id, this.nome, this.idade, required this.especiePet});

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(
    id: json['id']  ?? 0,
    nome: json['nome'] ?? '',
      especiePet: json['especiePet']
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'especiePet': especiePet
    };
  }
}