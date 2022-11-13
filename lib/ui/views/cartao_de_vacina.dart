import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsPet.dart';

import '../components/widgets/appbar/app_bar_pet.dart';

class CartaoDeVacina extends StatefulWidget {
  const CartaoDeVacina({Key? key}) : super(key: key);

  @override
  State<CartaoDeVacina> createState() => _CartaoDeVacinaState();
}

class _CartaoDeVacinaState extends State<CartaoDeVacina> {
  @override
  Widget build(BuildContext context) {
    ScreenArgumentsPet? args = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsPet?;

    return Scaffold(
      appBar: AppBarPet(args!),
      body: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
      children: [

        Text((args?.data != null) ? args?.data.imagePet : ""),
        Text("data2")
      ],
      ),

    );



  }
}
