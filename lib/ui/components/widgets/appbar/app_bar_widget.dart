import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/home.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';

import '../../../views/dono/cadastro_dono.dart';
import '../../../views/screen_arguments/ScreenArgumentsDono.dart';

class AppBarWidget extends PreferredSize {
AppBarWidget(ScreenArgumentsDono argsDono, BuildContext context,{Key? key}):super(key: key,

  preferredSize: const Size.fromHeight(200),

  child: Container(

  height: 120,
    decoration: const BoxDecoration(
      gradient: AppGradients.sol
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

         Padding(
           padding: const EdgeInsets.fromLTRB(0, 50, 0,0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
             Text("Lista dos Pets", style: AppTextStyles.title,),
             Text((argsDono.data.nome == null) ?  "" : '''Tutor: ${argsDono.data.nome}''',
               style: AppTextStyles.subTitleBold,),

           ],),
         ),

          GestureDetector(
            onTap: (){
              _showPopupMenu(context, argsDono);
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(

                  image: AssetImage(
                    "assets/images/pug.png",

                  )
                )
              ),
            ),
          )
        ],
      ),
    ),
  ),
);



}
void _showPopupMenu(BuildContext context, ScreenArgumentsDono argsTutor) async {
  await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(250, 100, 0, 0),
    items: [
       PopupMenuItem(
         onTap: ()  => Future(() => Navigator.pushNamed(context, '/cadastro_dono', arguments: ScreenArgumentsDono(argsTutor))
         )
         ,
        child: const ListTile(
          leading: Icon(Icons.person_add), // your icon
          title: Text("EDITAR"),
        ),
      ),
       PopupMenuItem(
        onTap: (){
          print("SAINDO");
        },
        child: const ListTile(
          leading: Icon(Icons.exit_to_app), // your icon
          title: Text("EXIT"),
        ),
      ),
    ],
    elevation: 8.0,
  );
}
