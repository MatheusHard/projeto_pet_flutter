import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/login.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

///Deletar tabelas:
  var removes = await DBHelper.instance.removeAllTiposPets();
  var removes2 = await DBHelper.instance.removeAllPets();

///Add TIpos:
  var _tipo1 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Gato"));
  var _tipo2 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Cachorro"));
  var _tipo3 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Bode"));

  ///Add PETs
  var _dado = await DBHelper.instance.addPet(
      Pet(
          nome: "Pombogato", tipoPet: 1, sexo: true, dataNascimento: Utils.getDataHora().toString(),
          idade: 2
      ));
 var _dado2 = await DBHelper.instance.addPet(
      Pet(
          nome: "Popoto", tipoPet: 2,  sexo: true, dataNascimento: Utils.getDataHora().toString(),
          idade: 2
      ));

  ///PET
  var _dado3 = await DBHelper.instance.addPet(
      Pet(
          nome: "Ariana", tipoPet: 3,  sexo: true, dataNascimento: Utils.getDataHora().toString(),
          idade: 2
      ));

  //var tipo = await DBHelper.instance.addEspe
//print(_dado);

  List _dados = await DBHelper.instance.getPetsJoinTipo();


  for (var p in _dados) {
    print("----------------------------------------");
    print('''ID: ${p['id']}''');
    print('''Nascido: ${Utils.formatarData(p['dataNascimento'], true) }''');
    print('''NOME: ${p['nome']}''');
    print('''Sexo: ${p['sexo']}''');
    print('''Tipo do Pet: ${p['descricao']}''');
    print("-----------------------------------------");


  }


  runApp(
      const MaterialApp(
        home: Login(),
        debugShowCheckedModeBanner: false,
      ));}

