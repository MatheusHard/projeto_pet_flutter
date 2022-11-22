import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsPet.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsVacina.dart';

import '../components/widgets/appbar/app_bar_pet.dart';
import '../components/widgets/cards/card_vacina.dart';

class CartaoDeVacina extends StatefulWidget {
  const CartaoDeVacina({Key? key}) : super(key: key);

  @override
  State<CartaoDeVacina> createState() => _CartaoDeVacinaState();
}

class _CartaoDeVacinaState extends State<CartaoDeVacina> {
  List<Vacina> _vacinas = [];

  @override
  void initState() {
    //_getVacinas('4ba5dea3-e974-4006-be5f-ba7183adbb6b');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenArgumentsPet? args = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScreenArgumentsPet?;

    _getVacinas(args?.data.id);

    return Scaffold(
      appBar: AppBarPet(args!),
      body: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children:
          List.generate(_vacinas.length, (index) {
            return CardVacina(
                data: _vacinas[index], onTap: (data) {

            });
          })


      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          //Navigator.pushNamed(context, '/cadastro_vacina',
            //  arguments: ScreenArgumentsVacina(args, false));
          Container();
        },
      ),
    );
  }

   _getVacinas(String petId) async {

     List<Vacina> list = await DBHelper.instance.getAllVacinasByPet(petId);
     _vacinas = list;
     setState(() {
        _vacinas;
      });
    }
  }

