import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/home.dart';

class PetBox extends StatelessWidget {

  PetBox ({ this.data, required this.onTap, Key? key}) : super(key: key);

  final data;
  final Function onTap; // Good



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: (){
          onTap(data);
              //Navigator.pushNamed(context, '/cartao_de_vacina',arguments: null));



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

                child: Text(data.nome.toString(),
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
