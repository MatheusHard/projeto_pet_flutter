import 'package:flutter/material.dart';

class Exemplo extends StatelessWidget {
  Exemplo(    {Key? key,
                this.title,
                required this.onPress
              }): super(key: key);
  var title;
  VoidCallback onPress; // Good

  @override
  Widget build(BuildContext context) {

    title ??= '''Sem Texto''';

    return Expanded(child: Container(
      height: 400,
      width: 400,
      color: Colors.amber,
      //tamanho externo:
      margin: const EdgeInsets.all(8.0),
      //tamalho interno:
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title),
          ElevatedButton(
          onPressed: onPress, child: const Text("SAlvar"),
          )
        ],
      ),
    )
    );
  }
}
/***
 *  DropdownSearch<String>(
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
 * */