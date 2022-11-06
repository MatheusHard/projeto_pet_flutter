import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/components/widgets/boxes/pet_box.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

import '../models/pet.dart';

class PrincipalPets extends StatefulWidget {


  const PrincipalPets({Key? key}) : super(key: key);

  @override
  State<PrincipalPets> createState() => _PrincipalPetsState();
}

class _PrincipalPetsState extends State<PrincipalPets> {
  late Image image;
  List<Pet> _pets = [];

  @override
  void initState() {
    super.initState();
    _getPets();
  }

  @override
  Widget build(BuildContext context) {

    var data = Pet(
        donoPet: 1, nome: "Ariana", tipoPet: 3,  sexo: true,
        dataNascimento: Utils.getDataHora().toString(),imagePet: 'FGJKFMDLDLMD');

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,

          children: [
            PetBox(
              data: data,
              onTap: (data){
                print("PET 1");
                print(data);
            },),
           PetBox(
               data: data,
               onTap: (data){
               print("PET 2");
               print(data);
             },),
            PetBox(
                data: data,
                onTap: (data){
                print("PET 3");
                print(data);
              },),

          ],

        ),
      ),
    );
  }
  _getPets() async {

    List listRecuperados = await DBHelper.instance.getPetsJoinTipo();
    List<Pet> contasTemporarias = [];
    for(var item in listRecuperados){
      Pet c = Pet.fromMap(item);
      contasTemporarias.add(c);
    }
    setState(() {
      _pets = contasTemporarias;

    });
    contasTemporarias.clear();
  }
}
