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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                    child: Center(child: Text(data?.nomeVacina.toUpperCase(),
                                      style: AppTextStyles.vacinaDose,),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Utils.showDose(data?.dose),
                      style: AppTextStyles.vacinaDose,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text((data.dataAplicacao != null && data.dataAplicacao != "") ? "Aplicada: ${Utils.formatarData(data?.dataAplicacao, true)}" : "Não aplicada!!" ,
                      style: (data.dataAplicacao != null && data.dataAplicacao != "") ? AppTextStyles.vacinaAplicada: AppTextStyles.vacinaNaoAplicada),
                  ),
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
