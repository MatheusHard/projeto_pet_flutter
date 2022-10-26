

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:projeto_pet/ui/components/exemplo.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';


class CadastroPets extends StatefulWidget {
  const CadastroPets({Key? key}) : super(key: key);

  @override
  State<CadastroPets> createState() => _CadastroPetsState();
}

class _CadastroPetsState extends State<CadastroPets> {

  var selectedItem = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: const BoxDecoration(gradient: AppGradients.linear),
      color: Colors.white,
      margin: const EdgeInsets.only(top: 100),

        child:
      Column(children: [


        DropdownSearch<String>(
          popupSafeArea: const PopupSafeArea(
            top: true,
            bottom: true
          ),
        mode: Mode.MENU,
        showSelectedItems: true,
        showSearchBox: true,

dialogMaxWidth: 500,
    showAsSuffixIcons: true,
//        showFavoriteItems: true,
        items: ["Cabedelo", "João PEssoa", "Santa Rita", "Bayeux", "Natal"],
      label: "Menu Mode",
      hint: "Cidades",
      onChanged: (value){
          print(value);
      },
        selectedItem: selectedItem,

      ),
        /* Exemplo(
              title: "PRecionado",
            onPress:() {
              print("FFFF");
            }),
       Exemplo(
            title: "Dois",
            onPress:() {
              print("GGGGGGGGGG");
            })*/
      ],)

    );
  }
}
