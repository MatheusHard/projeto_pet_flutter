import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/login.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  ///PET
/*  var _dado = await DBHelper.instance.addPet(
      Pet(
          nome: "Pombogato", especiePet: 2,  sexo: false, dataNascimento: Utils.getDataHora().toString(),
          idade: 2
      ));*/
//print(_dado);

  List _dados = await DBHelper.instance.getPets();


  for (var p in _dados) {
    print("----------------------------------------");
    print('''ID: ${p.id} , NOME: ${p.nome} Nascido: ${p.dataNascimento} Sexo: ${p.sexo}''');
    print("-----------------------------------------");

  }


  runApp(
      const MaterialApp(
        home: Login(),
        debugShowCheckedModeBanner: false,
      ));}

