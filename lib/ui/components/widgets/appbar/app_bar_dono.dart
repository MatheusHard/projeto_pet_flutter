
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsDono.dart';

class AppBarDono extends PreferredSize {
  AppBarDono(ScreenArgumentsDono? args, {Key? key}):super(key: key,

    preferredSize: const Size.fromHeight(200),

    child: Container(

      height: 120,
      decoration: const BoxDecoration(
        gradient:  AppGradients.petMacho,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0,0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cadastro do Dono", style: AppTextStyles.titleCartaoVacina,),

                ],),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,25,0,0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const SizedBox(
                  width: 60,
                  height: 60,
                  child:  Icon(Icons.person_add, color: Colors.white,),

                ),
              ),
            ),

          ],
        ),
      ),
    ),
  );

}
