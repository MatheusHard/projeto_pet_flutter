import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/views/cadastro_pets.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/home.dart';
import 'package:projeto_pet/ui/views/login.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

///Deletar tabelas:
  var removes = await DBHelper.instance.removeAllTiposPets();
  //var removes2 = await DBHelper.instance.removeAllPets();
  var removes3 = await DBHelper.instance.removeAllDonos();

///Add TIpos:
  var _tipo1 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Gato"));
  var _tipo2 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Cachorro"));
  var _tipo3 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Cavalo"));
  var _tipo4 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Papagaio"));
  var _tipo5 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Ourobu"));



  ///Add PETs
  /*var _dado = await DBHelper.instance.addPet(Pet( donoPet: 1, nome: "Pombogato", tipoPet: 1, sexo: true, dataNascimento: Utils.getDataHora().toString(), imagePet: '2'));
  var _dado2 = await DBHelper.instance.addPet(Pet( donoPet: 2, nome: "Popoto", tipoPet: 2,  sexo: true, dataNascimento: Utils.getDataHora().toString(), imagePet: '2'));
  var _dado3 = await DBHelper.instance.addPet(Pet( donoPet: 1, nome: "Ariana", tipoPet: 3,  sexo: true, dataNascimento: Utils.getDataHora().toString(),imagePet: '2'));
*/
  ///Add Donos
  var _dono = await DBHelper.instance.addDono(Dono(nome: "Matheus", cpf: "05694641450", password: "fredf",user: "burumungu"));
  var _dono2 = await DBHelper.instance.addDono(Dono(nome: "Lolo", cpf: "0314641450", password: "fredf",user: "lolozinho"));

  List _dados = await DBHelper.instance.getDonoPets();

 List pets =  await  DBHelper.instance.getAllPets();

  /*for (var p in pets) {
    print("----------------------------------------");
    print('''PET: ${p['nome']}''');
    print('''NAsc: ${p['dataNascimento']}''');
    print('''FOTO: ${p['imagePet']}''');

    print("-----------------------------------------");

  }*/

  for (var p in _dados) {
    print("--------------DONO---------------------");
    print('''Dono: ${p['nome']}''');
    print('''Cpf: ${p['cpf']}''');
    print("----------------SEU PET----------------------");
    print('''PET: ${p['nomePet']}''');
    //print('''Nascido: ${Utils.formatarData(p['dataNascimento'], true) }''');
    //print('''Sexo: ${p['sexo']}''');
    //print('''Tipo do Pet: ${p['descricao']}''');
    print("-----------------------------------------");

  }


  runApp(
        MaterialApp(
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => const Home(),
          '/cadastro_pets': (context) => const CadastroPets(),

        },initialRoute: '/login',
        debugShowCheckedModeBanner: false,
      ));}

