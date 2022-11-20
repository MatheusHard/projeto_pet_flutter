
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsVacina.dart';

class AppBarVacina extends PreferredSize {
  AppBarVacina(ScreenArgumentsVacina args, {Key? key}):super(key: key,

    preferredSize: const Size.fromHeight(200),

    child: Container(

      height: 120,
      decoration: const BoxDecoration(
        gradient:  AppGradients.sol,
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
                  Text("Cadastro da Vacina", style: AppTextStyles.titleCartaoVacina,),

                ],),
            )

          ],
        ),
      ),
    ),
  );

}
