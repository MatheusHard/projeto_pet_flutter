

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';


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

  margin: EdgeInsets.only(top: 100),

        child: DropdownSearch<String>(
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

    );
  }
}
