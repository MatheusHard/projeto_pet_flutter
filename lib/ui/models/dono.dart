
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';

class Dono {

  int? id;
  String nome;
  String? cpf;
  String user;
  String password;
  Pet? pet;

  Dono({
    this.id, required this.nome, this.cpf,
    required this.user, required this.password, this.pet});

  factory Dono.fromMap(Map<String, dynamic> json) => Dono(

      id: json['id']  ?? 0,
      nome: json['nome'] ?? '',
      cpf: json['cpf'],
      user: json['user'],
      password:  (json['password']),
      pet: Pet.fromMap(json)
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'user': user,
      'password': password

    };
  }
}