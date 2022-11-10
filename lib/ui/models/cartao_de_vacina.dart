import 'package:projeto_pet/ui/models/tipo_pet.dart';

class CartaoDeVacina {

  int? id;
  ///Polivalente
  String? vacinaPolivalenteV10;
  String? vacinaPolivalenteV10D1;
  String? vacinaPolivalenteV10D2;
  String? vacinaPolivalenteV10D3;
  String? vacinaPolivalenteV10D4;
  ///Antirabica
  String? vacinaAntirrabica;
  String? vacinaAntirrabicaD1;
  String? vacinaAntirrabicaREF;
  ///Gripe
  String? vacinaGripe;
  String? vacinaGripeD1;
  String? vacinaGripeREF;
  ///Giardia
  String? vacinaGiardia;
  String? vacinaGiardiaD1;
  String? vacinaGiardiaREF;
  ///LeishmanioseVisceral
  String? vacinaLeishmanioseVisceral;
  String? vacinaLeishmanioseVisceralD1;
  String? vacinaLeishmanioseVisceralREF;
  ///LeishmanioseTegumentar
  String? vacinaLeishmanioseTegumentar;
  String? vacinaLeishmanioseTegumentarD1;
  String? vacinaLeishmanioseTegumentarREF;
  int petId;
  String dataCadastro;

  CartaoDeVacina({this.id, this.vacinaPolivalenteV10, this.vacinaPolivalenteV10D1,  this.vacinaPolivalenteV10D2,this.vacinaPolivalenteV10D3,this.vacinaPolivalenteV10D4,
    this.vacinaAntirrabica, this.vacinaAntirrabicaD1, this.vacinaAntirrabicaREF, this.vacinaGripe,this.vacinaGripeD1, this.vacinaGripeREF,
    this.vacinaGiardia,this.vacinaGiardiaD1, this.vacinaGiardiaREF, this.vacinaLeishmanioseVisceral,this.vacinaLeishmanioseVisceralD1,
    this.vacinaLeishmanioseVisceralREF, this.vacinaLeishmanioseTegumentar,this.vacinaLeishmanioseTegumentarD1,this.vacinaLeishmanioseTegumentarREF,
    required this.petId, required this.dataCadastro
  });


  factory CartaoDeVacina.fromMap(Map<String, dynamic> json) => CartaoDeVacina(

    id: json['id'],
    petId: json['petId'],
    dataCadastro: json['dataCadastro'],

    vacinaPolivalenteV10: json['vacinaPolivalenteV10'],
    vacinaPolivalenteV10D1: json['vacinaPolivalenteV10D1'],
    vacinaPolivalenteV10D2: json['vacinaPolivalenteV10D2'],
    vacinaPolivalenteV10D3:  json['vacinaPolivalenteV10D3'],
    vacinaPolivalenteV10D4: json['vacinaPolivalenteV10D4'],

    vacinaAntirrabica: json['vacinaAntirrabica'],
    vacinaAntirrabicaD1: json['vacinaAntirrabicaD1'],
    vacinaAntirrabicaREF: json['vacinaAntirrabicaREF'],

    vacinaGripe: json['vacinaGripe'],
    vacinaGripeD1: json['vacinaGripeD1'],
    vacinaGripeREF:  json['vacinaGripeREF'],

    vacinaGiardia: json['vacinaGiardia'],
    vacinaGiardiaD1: json['vacinaGiardiaD1'],
    vacinaGiardiaREF: json['vacinaGiardiaREF'],

    vacinaLeishmanioseVisceral: json['vacinaLeishmanioseVisceral'],
    vacinaLeishmanioseVisceralD1: json['vacinaLeishmanioseVisceralD1'],

    vacinaLeishmanioseTegumentar:  json['vacinaLeishmanioseTegumentar'],
    vacinaLeishmanioseTegumentarD1: json['vacinaLeishmanioseTegumentarD1'],
    vacinaLeishmanioseTegumentarREF: json['vacinaLeishmanioseTegumentarREF']

  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'petId': petId,
      'dataCadastro': dataCadastro,

      'vacinaPolivalenteV10': vacinaPolivalenteV10,
      'vacinaPolivalenteV10D1': vacinaPolivalenteV10D1,
      'vacinaPolivalenteV10D2': vacinaPolivalenteV10D2,
      'vacinaPolivalenteV10D3': vacinaPolivalenteV10D3,
      'vacinaPolivalenteV10D4': vacinaPolivalenteV10D4,

      'vacinaAntirrabica': vacinaAntirrabica,
      'vacinaAntirrabicaD1': vacinaAntirrabicaD1,
      'vacinaAntirrabicaREF': vacinaAntirrabicaREF,

      'vacinaGripe': vacinaGripe,
      'vacinaGripeD1': vacinaGripeD1,
      'vacinaGripeREF':  vacinaGripeREF,

      'vacinaGiardia': vacinaGiardia,
      'vacinaGiardiaD1': vacinaGiardiaD1,
      'vacinaGiardiaREF': vacinaGiardiaREF,

      'vacinaLeishmanioseVisceral': vacinaLeishmanioseVisceral,
      'vacinaLeishmanioseVisceralD1': vacinaLeishmanioseVisceralD1,
      'vacinaLeishmanioseVisceralREF': vacinaLeishmanioseVisceralREF,

      'vacinaLeishmanioseTegumentar':  vacinaLeishmanioseTegumentar,
      'vacinaLeishmanioseTegumentarD1': vacinaLeishmanioseTegumentarD1,
      'vacinaLeishmanioseTegumentarREF': vacinaLeishmanioseTegumentarREF
    };
  }
}