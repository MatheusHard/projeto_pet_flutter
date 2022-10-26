import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/home.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';

class AppBarWidget extends PreferredSize {
AppBarWidget(ScreenArguments args, {Key? key}):super(key: key,

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
         Center(

             child:

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0,0),
            child: Column(children: [
              Text("Pets", style: AppTextStyles.title,),
              Text(args.name, style: AppTextStyles.subTitleBold,),

            ],),
          )),
          Container(
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
          )
        ],
      ),
    ),
  ),
);

}
