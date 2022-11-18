import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/components/widgets/boxes/pet_box.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
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
 //pets_teste =  getListTeste();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          body:



         GridView.count(
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
        /*  Column(
            children: [
            Expanded(child:
            ListView.builder(
              itemCount: _pets.length,
                itemBuilder: (context, index){
                  final item =_pets[index];
                  return Card(
                    child: Text(item.nome),
                  );
                }

            ))
            ],
          )*/




          ),
        ));

  }

  /*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Lista no Grid";
    return MaterialApp(
      title: title,
      home: Scaffold(appBar: AppBar(
        title: Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(opcoes.length, (index) {
              return Center(
                child: OpcaoCard(opcao: opcoes[index]),
              );
           }
          )
        )
      )
    );
  }
}
class Opcao {
  const Opcao({this.titulo, this.icon});
  final String titulo;
  final IconData icon;
}
const List<Opcao> opcoes = const <Opcao>[
  const Opcao(titulo: 'Carro', icon: Icons.directions_car),
  const Opcao(titulo: 'Bike', icon: Icons.directions_bike),

  const Opcao(titulo: 'Barco', icon: Icons.dvr),
];
class OpcaoCard extends StatelessWidget {
  const OpcaoCard({Key key, this.opcao}) : super(key: key);
  final Opcao opcao;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context)
.textTheme.display1;
        return Card(
          color: Colors.white,
          child: Center(*/

  _getPets() async {

    List list = await DBHelper.instance.getPetsJoinTipo();
    //List<Pet> petsTemporarios = <Pet>[];
    for (var item in list) {
      Pet pet = Pet.fromMap(item);
     //petsTemporarios.add(pet);
      _pets.add(pet);
    }
     // _pets = petsTemporarios;
    setState(() {
      _pets;
    });
    //petsTemporarios.clear();

  }
}
