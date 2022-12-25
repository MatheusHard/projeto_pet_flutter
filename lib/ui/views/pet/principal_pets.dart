import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/components/widgets/boxes/pet_box.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsPet.dart';

import '../../models/pet.dart';
import '../screen_arguments/ScreenArgumentsDono.dart';


class PrincipalPets extends StatefulWidget {

  final ScreenArgumentsDono tutor;
  const PrincipalPets({required this.tutor, Key? key}) : super(key: key);

  @override
  State<PrincipalPets> createState() => _PrincipalPetsState();
}

class _PrincipalPetsState extends State<PrincipalPets> {
  late Image image;
  final List<Pet> _pets = [];
  late ScreenArgumentsDono _tutor;


  @override
  void initState() {
    _tutor = widget.tutor;

    _getPets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
            floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/cadastro_pets',arguments: ScreenArgumentsPet(null,  _tutor.data));
            },
          ),
          bottomSheet: Padding(
                              padding: const EdgeInsets.only(top: 0, right: 0, bottom: 20, left: 20),
                              child: Text("Pets: ${_pets.length}", style: AppTextStyles.total),
                            ),
          body: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: (_tutor.data.qtdRowListagem != null) ? _tutor.data.qtdRowListagem : 2,
        children: List.generate(_pets.length, (index) {
      return PetBox(
        data: _pets[index],
        onTap: (data) {
          Navigator.popAndPushNamed(context, '/cartao_de_vacina',arguments: ScreenArgumentsPet(data, _tutor.data));
      },
      );
    }),
             ),
        ));

  }

  _getPets() async {

    List list = await DBHelper.instance.getPetsJoinTipo(_tutor.data.id);
    for (var item in list) {
      Pet pet = Pet.fromMap(item);
      _pets.add(pet);
    }
    setState(() {
      _pets;
    });

  }
}
