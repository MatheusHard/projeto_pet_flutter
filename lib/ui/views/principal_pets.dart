import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/components/widgets/boxes/pet_box.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsPet.dart';

import '../models/pet.dart';
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
    _getPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          bottomSheet: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 0, bottom: 20, left: 20),
                              child: Text("Pets: ${_pets.length}", style: AppTextStyles.total),
                            ),
          body: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
        children: List.generate(_pets.length, (index) {
      return PetBox(
        data: _pets[index],
        onTap: (data) {
          Navigator.pushNamed(context, '/cartao_de_vacina',arguments: ScreenArgumentsPet(data));
      },
      );
    }),
             ),
        ));

  }

  _getPets() async {

    List list = await DBHelper.instance.getPetsJoinTipo();
    for (var item in list) {
      Pet pet = Pet.fromMap(item);
      _pets.add(pet);
    }
    setState(() {
      _pets;
    });

  }
}
