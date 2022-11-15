import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_colors.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

class CardVacina extends StatelessWidget {

  const CardVacina({required this.data, required this.onTap, Key? key}) : super(key: key);

  final data;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: (){
          print("CVACINAS");
          //onTap(data);
         // Navigator.pushNamed(context, '/home',arguments: null);
        },
        child:
        Stack(
          clipBehavior: Clip.none,
          children: [
            AspectRatio(
              aspectRatio: 1/1,
              child: Container(
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("data"),
                  ),
                  Text("data"),
                ],
              ),
            ),

            const Align(
                alignment: Alignment(0.9, 0.9),
                child:
                Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 0),
                  child: Icon(
                    Icons.vaccines,
                    color: Colors.green,
                    size: 50,),),
                )
          ],
        ),
            ),




    );
  }
}
