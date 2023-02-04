import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/api/sincronismo_dados.dart';
import 'package:projeto_pet/ui/models/tipo_vacina.dart';
import 'package:projeto_pet/ui/views/dono/cadastro_dono.dart';
import 'package:projeto_pet/ui/views/dono/esqueci_acesso.dart';
import 'package:projeto_pet/ui/views/pet/cadastro_pets.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsDono.dart';
import 'package:projeto_pet/ui/views/vacina/cadastro_vacina.dart';
import 'package:projeto_pet/ui/views/vacina/cartao_de_vacina.dart';
import 'package:projeto_pet/ui/views/home.dart';
import 'package:projeto_pet/ui/views/login.dart';

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
  //var _dono = await DBHelper.instance.addDono(Dono(nome: "Matheus", cpf: "05694641450", password: "fredf",user: "burumungu", qtdRowListagem: 2));
  //var _dono2 = await DBHelper.instance.addDono(Dono(nome: "Lolo", cpf: "0314641450", password: "fredf",user: "lolozinho", qtdRowListagem: 3));
  SincronismoDados.getPaises();

  List _dados = await DBHelper.instance.getDonoPets();

 List pets =  await  DBHelper.instance.getAllPets();

 List vacinas2 = await DBHelper.instance.getAllVacinasByPet('4ba5dea3-e974-4006-be5f-ba7183adbb6b');
  List vacinas = await DBHelper.instance.getAllVacinas();





  for (var p in _dados) {
    print("--------------DONO---------------------");
    print('''Dono: ${p['nome']}''');
    print('''Cpf: ${p['cpf']}''');
    print('''Qtd List: ${p['qtdRowListagem']}''');
    print('''User: ${p['user']}''');
    print("-----------------------------------------");

  }

  var tutor = ScreenArgumentsDono( null);
  runApp(
        MaterialApp(
        routes: {
          '/login': (context) => const Login(),
          '/home': (context) => const Home(),
          '/cadastro_pets': (context) =>  const CadastroPets(),
          '/cartao_de_vacina': (context) => const CartaoDeVacina(),
          '/cadastro_vacina': (context) => const CadastroVacina(),
          '/cadastro_dono' : (context) => const CadastroDono(),
          '/esqueci_acesso' : (context) => const EsqueciAcesso()

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



