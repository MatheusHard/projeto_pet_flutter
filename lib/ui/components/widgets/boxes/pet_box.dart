import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';

class PetBox extends StatelessWidget {

  PetBox ({ @required this.data, required this.onTap, Key? key}) : super(key: key);

  final data;
  final Function onTap; // Good



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: (){
          onTap(data);
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
                  child: Image.asset(
                    "assets/images/pug.png",
                    fit: BoxFit.cover,
                  ),
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
            const Positioned(
                left: 0,
                right: 0,
                bottom: 10,

                child: Text("NOme do Pet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            color: Colors.white
                ),),
            )
          ],
        ),
      ),
    );
  }
}
