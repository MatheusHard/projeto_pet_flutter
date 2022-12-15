import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/views/pet/cadastro_pets.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/views/pet/principal_pets.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsDono.dart';

import '../components/widgets/appbar/app_bar_widget.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    ScreenArgumentsDono argsDono = ModalRoute.of(context)?.settings.arguments as ScreenArgumentsDono;

    final tabs = [

       PrincipalPets(tutor: argsDono, ),
       //CadastroPets(tutor: argsDono,),
      const Center(child: Text("PET")),

      const Center(child: Text("Nuvem")),
      const Center(child: Text("EXIT"))
    ];

    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(argsDono!, context),
        body: tabs[_currentIndex],

        bottomNavigationBar:
        Container(
            decoration: const BoxDecoration(
                gradient: AppGradients.sol
            ),
            child:
            CurvedNavigationBar(

              items: const [
                Icon(Icons.home, size: 20, color: Colors.white,),
                Icon(Icons.add, size: 20, color: Colors.white,),
                Icon(Icons.cloud_download, size: 20,  color: Colors.white,),
                Icon(Icons.exit_to_app, size: 20, color: Colors.white,),
              ],
              color: Colors.transparent,

              buttonBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,

              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 600),
              index: 0,
              height: 50,
              onTap: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
            ) /*BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 12.0,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,),
              backgroundColor: Colors.orangeAccent,
              title: Text(Textos().home, style: TextStyle(color: Colors.white),)),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.white,),
              backgroundColor: Colors.greenAccent,
              title: Text(Textos().cadastrar, style: TextStyle(color: Colors.white),)),
          BottomNavigationBarItem(icon: Icon(Icons.cloud_download, color: Colors.white,),
              backgroundColor: Colors.blueAccent,
              title: Text(Textos().sincronizar, style: TextStyle(color: Colors.white),)),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app, color: Colors.white,),
              backgroundColor: Colors.redAccent,
              title: Text(Textos().sair, style: TextStyle(color: Colors.white),)),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),*/
        )
    );
  }
}


class ScreenArguments {
  final String name;
  ScreenArguments(this.name);
}
