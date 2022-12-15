
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsPet.dart';

class AppBarCadastroPet extends PreferredSize {
  AppBarCadastroPet(ScreenArgumentsPet? args, {Key? key}):super(key: key,

    preferredSize: const Size.fromHeight(200),

    child: Container(

      height: 120,
      decoration: const BoxDecoration(
        gradient:  AppGradients.cadastroPet,
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
                  Text((args?.data == null) ?  "Cadastrar Pet" : "Atualizar Pet", style: AppTextStyles.titleCartaoVacina,),
                  Text((args?.data != null) ?  args?.data.nome.toUpperCase() : "", style: AppTextStyles.subTitleBold,),

                ],),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,50,0,0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const SizedBox(
                  width: 50,
                  height: 50,
                 // child:  Utils.imageFromBase64String(args?.data.imagePet),

                ),
              ),
            ),

          ],
        ),
      ),
    ),
  );

}
