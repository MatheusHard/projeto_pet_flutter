import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/home.dart';

import '../../../utils/core/app_colors.dart';

class PetBox extends StatelessWidget {

  const PetBox ({ this.data, required this.onTap, required this.onLongTap, Key? key}) : super(key: key);

  final data;
  final Function onTap; // Good
  final Function onLongTap;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: (){
          onTap(data);
              //Navigator.pushNamed(context, '/cartao_de_vacina',arguments: null));
        },
        onLongPress: (){
          onLongTap(data);
        },
        child: Stack(
          children: [
            AspectRatio(
                aspectRatio: 1/1,
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey
                  ),
                ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:    Utils.imageFromBase64String(data.imagePet),

            )
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppGradients.boxPetGradient
                  ),
                )
            ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,

                child: Text(data?.nome.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                            color: Colors.white
                ),),
            )
          ],
        ),
      ),
    );
  }
}
