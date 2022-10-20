
class Pet {

  int? id;
  String nome;
  int especiePet;
  int? idade;
  String? dataNascimento;
  bool sexo;

  Pet({
       this.id, required this.nome, this.idade,
       required this.especiePet, this.dataNascimento, required this.sexo});

  factory Pet.fromMap(Map<String, dynamic> json) => Pet(

    id: json['id']  ?? 0,
    nome: json['nome'] ?? '',
    especiePet: json['especiePet'],
    dataNascimento: json['dataNascimento'],
    sexo:  (json['sexo'] == 1) ? true: false
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'especiePet': especiePet,
      'dataNascimento': dataNascimento,
      'sexo': sexo
    };
  }
}