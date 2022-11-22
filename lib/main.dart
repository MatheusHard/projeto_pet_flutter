import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/models/tipo_vacina.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
import 'package:projeto_pet/ui/views/cadastro_pets.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/models/pet.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/cadastro_vacina.dart';
import 'package:projeto_pet/ui/views/cartao_de_vacina.dart';
import 'package:projeto_pet/ui/views/home.dart';
import 'package:projeto_pet/ui/views/login.dart';
import 'package:uuid/uuid.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  ///Deletar tabelas:
  await DBHelper.instance.removeAllTiposPets();
  //await DBHelper.instance.removeAllPets();
  //await DBHelper.instance.removeAllDonos();
  await DBHelper.instance.removeAllTiposVacinas();
  //await DBHelper.instance.removeAllVacinas();

///Add Tipos Pets:
  setTiposPet();
  ///Add TIpo Vacinas
  setTiposVacina();
  ///Add VAcians
  //setVacinas();

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

 List vacinas2 = await DBHelper.instance.getAllVacinasByPet('4ba5dea3-e974-4006-be5f-ba7183adbb6b');
  List vacinas = await DBHelper.instance.getAllVacinas();




  print("vacinas");
 print(vacinas);

  print("vacinas22222");
  print(vacinas2);

  for (var p in vacinas) {
    print("----------------------------------------");
    print('''PET ID: ${p.petId}''');

    print("-----------------------------------------");

  }

  /*for (var p in _dados) {
    print("--------------DONO---------------------");
    print('''Dono: ${p['nome']}''');
    print('''Cpf: ${p['cpf']}''');
    print("----------------SEU PET----------------------");
    print('''PET: ${p['nomePet']}''');
    //print('''Nascido: ${Utils.formatarData(p['dataNascimento'], true) }''');
    //print('''Sexo: ${p['sexo']}''');
    //print('''Tipo do Pet: ${p['descricao']}''');
    print("-----------------------------------------");

  }*/


  runApp(
        MaterialApp(
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => const Home(),
          '/cadastro_pets': (context) => const CadastroPets(),
          '/cartao_de_vacina': (context) => const CartaoDeVacina(),
          '/cadastro_vacina': (context) => const CadastroVacina()

        },initialRoute: '/login',
        debugShowCheckedModeBanner: false,
      ));}

void setTiposPet() async{

  var _tipo1 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Gato"));
  var _tipo2 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Cachorro"));
  var _tipo3 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Cavalo"));
  var _tipo4 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Papagaio"));
  var _tipo5 = await DBHelper.instance.addTipoPet(TipoPet(descricao: "Ourobu"));
}
void setTiposVacina() async{
   print("Cadastros dos Tipos de Vacinas");
   await DBHelper.instance.addTipoVacina(TipoVacina(dataCadastro: Utils.getDataHora().toString(), nomeVacina: "Esporotricose"));
   await DBHelper.instance.addTipoVacina(TipoVacina(dataCadastro: Utils.getDataHora().toString(), nomeVacina: "Sarna"));
   await DBHelper.instance.addTipoVacina(TipoVacina(dataCadastro: Utils.getDataHora().toString(), nomeVacina: "Doença do Carrapato"));
   print("FIM Tipos de Vacinas");

}

/*void setVacinas() async{
  print("Cadastros dos de Vacinas");
  ///Poli
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Polivalente V10", dataAplicacao: null, dose: 'D1', petId: 1));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Polivalente V10", dataAplicacao: null, dose: 'D2', petId: 1));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Polivalente V10", dataAplicacao: null, dose: 'D3', petId: 1));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Polivalente V10", dataAplicacao: null, dose: 'D4', petId: 1));


  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Antirrabica",  dataAplicacao: null, dose: 'D1', petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Antirrabica",  dataAplicacao: null, dose: 'REF', petId: 2));

  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Gripe",  dataAplicacao: null, dose: 'D1', petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Gripe",  dataAplicacao: null, dose: 'REF', petId: 2));

  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Giardia",  dataAplicacao: null,dose: 'D1', petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Giardia",  dataAplicacao: null, dose: 'REF',petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Visceral",  dataAplicacao: null,dose: 'D1', petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Visceral",  dataAplicacao: null,dose: 'REF', petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Tegumentar",  dataAplicacao: null,dose: 'D1', petId: 2));
  await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Tegumentar",  dataAplicacao: null,dose: 'REF', petId: 2));




}*/

