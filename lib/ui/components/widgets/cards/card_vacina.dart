import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
import 'package:projeto_pet/ui/utils/core/app_colors.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_images.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import '../../../views/screen_arguments/ScreenArgumentsVacina.dart';

class CardVacina extends StatefulWidget {

  const CardVacina({required this.data, required this.onTap, Key? key}) : super(key: key);

  final data;
  final Function onTap;

  @override
  State<CardVacina> createState() => _CardVacinaState();
}

class _CardVacinaState extends State<CardVacina> {
  DateTime date = DateTime.now();

  var selectedItemTipoVacina;

  late List _listaTiposVacinas = [];




  final _dataController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool vacinaPadraoOrOutra = false;

  String nome = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool vacinaPadraoOrOutra = true;

    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () async{
            await showInformationDialog(context, ScreenArgumentsVacina(widget.data, vacinaPadraoOrOutra));
            //Navigator.pushNamed(context, '/cadastro_vacina',
            //arguments: ScreenArgumentsVacina(data, vacinaPadraoOrOutra));
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
                      child: Center(child: Text(widget.data?.nomeVacina.toUpperCase(),
                                        style: AppTextStyles.vacinaNome,),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(Utils.showDose(widget.data?.dose),
                        style: AppTextStyles.vacinaDose,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text((widget.data.dataAplicacao != null && widget.data.dataAplicacao != "") ? "Aplicada: ${Utils.formatarData(widget.data?.dataAplicacao, true)}" : "Não aplicada!!" ,
                        style: (widget.data.dataAplicacao != null && widget.data.dataAplicacao != "") ? AppTextStyles.vacinaAplicada: AppTextStyles.vacinaNaoAplicada),
                    ),
                  ],
                ),
              ),

               Align(

                  alignment: const Alignment(0.9, 0.9),
                  child:
                Container(
                  width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   image:  DecorationImage(

                       image: AssetImage(
                         AppImages.vacina_card,

                       )
                   )
               ),
                )
                  )
            ],
          ),
              ),




      ),
    );
  }

  ///DIALOG CADASTRO VACINA:
  Future<void> showInformationDialog(BuildContext context, ScreenArgumentsVacina argsVacina) async {

    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Atualizar Vacina",),
          titleTextStyle: AppTextStyles.titleCardVacina,
          contentPadding: const EdgeInsets.only(left: 5, bottom: 0, right: 5, top: 0),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey
                ),
                width: 400,
                height: 400,
                child: Scaffold(
                  body:  Form(
                    key: _formKey,
                    child: Stack(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Center(

                                child: SingleChildScrollView(
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0, top: 20.0, right: 0, bottom: 40),
                                        child: Text(argsVacina.data.nomeVacina.toUpperCase(), style: AppTextStyles.vacinaNome,),
                                      ),
                                      ///Atualizar Vacina Padrao:

                                      widgetDataAplicacao(argsVacina),
                                      widgetDosePadrao(argsVacina),
                                      widgetDataAPlicada(argsVacina)
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ]
                    ),
                  ),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: ()  {
                    if (_formKey.currentState!.validate() &&
                    validateVacina()) {
                      _atualizarVacina(argsVacina!, context);
                    } else {
                      Utils.showDefaultSnackbar(
                      context, "Preencha os campos Obrigatórios!!!");
                      }},
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  widgetDataAplicacao(ScreenArgumentsVacina args) {

      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 8),
        child: TextFormField(
          readOnly: true,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate:  date,
                firstDate: DateTime(1900),
                lastDate: DateTime(2040));
            if (newDate == null) return;
            setState(() {
              date = newDate;
              _dataController.value = TextEditingValue(


                  text: Utils.formatarDateTime(date));
                  //text: (args.data.dataAplicacao == "") ? Utils.formatarDateTime(date) : args.data.dataAplicacao.toString());
              });
          },
          keyboardType: TextInputType.datetime,
          controller: _dataController,
          decoration: const InputDecoration(
            icon: Icon(Icons.date_range, color: Colors.green),
            hintText: "Data da Aplicação",
          ),

          validator: (value) {
            if (value == null || value == "") {
              return "Data de Aplicação Obrigatória!!!";
            }
            return null;
          },
        ),

      );
    }


  widgetDosePadrao(ScreenArgumentsVacina args) {

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(Utils.showDose(args.data?.dose),
          style: AppTextStyles.vacinaDose,),
      );
    }



  clearControllers() {
    _dataController.clear();
  }

   _atualizarVacina(ScreenArgumentsVacina args, BuildContext context) async {

    String doseVacina = args.data.dose;
    String petId = args.data.petId;
    String vacina = args.data.nomeVacina;
    int id = args.data.id;

    DBHelper.instance.updateVacina(Vacina(id: id, nomeVacina: vacina, dose: doseVacina, petId: petId, dataAplicacao: date.toString()));
    clearControllers();
    Utils.showDefaultSnackbar(context, "Cadastro atualizado com sucesso!!!");
    Navigator.pop(context, 'Cancel');

  }

  bool validateVacina() {
    bool flag = true;
    if (_dataController.text.isEmpty) return false;
    return flag;
  }

  widgetDataAPlicada(ScreenArgumentsVacina args) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text((args.data.dataAplicacao != null && args.data.dataAplicacao != "") ? "Aplicada anteriormente: ${Utils.formatarData(args.data?.dataAplicacao, true)}" : "Não aplicada!!" ,
          style: (args.data.dataAplicacao != null && args.data.dataAplicacao != "") ? AppTextStyles.vacinaAplicada: AppTextStyles.vacinaNaoAplicada),
    );
  }
}





