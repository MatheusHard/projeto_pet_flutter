import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_pet/ui/components/widgets/appbar/app_bar_pet.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsVacina.dart';

import '../components/widgets/appbar/app_bar_vacina.dart';

class CadastroVacina extends StatefulWidget {
  const CadastroVacina({Key? key}) : super(key: key);

  @override
  State<CadastroVacina> createState() => _CadastroVacinaState();
}

class _CadastroVacinaState extends State<CadastroVacina> {

  DateTime date = DateTime.now();

  final _picker = ImagePicker();
  var selectedItemTipoVacina;
  late List _listaTiposVacinas = [];
  late FocusNode _myFocusNodeNome;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  //final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool vacinaPadraoOrOutra = false;
  String nome = "";

  @override
  void initState() {
    getTiposVacinas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ScreenArgumentsVacina? argsVacina = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScreenArgumentsVacina?;

///    vacinaPadraoOrOutra = argsVacina?.vacinaPadraoOrOutra!;

    return Scaffold(
      appBar: AppBarVacina(argsVacina!),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              "Vacina", style: AppTextStyles.titlePet,),
                          ),

                        ///Add Vacina Padrao ou Nova:
                          widgetTipoVacinaPadraoOrNova(argsVacina?.vacinaPadraoOrOutra),
                          widgetDosePadraoOrNova(argsVacina, argsVacina?.vacinaPadraoOrOutra),
                        ///SALVAR VACINA
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    validateVacina()) {
                                  _cadastrarVacina(argsVacina!);
                                } else {
                                  Utils.showDefaultSnackbar(
                                      context, "Preencha os campos Obrigatórios!!!");
                                }
                              },
                              child: const Text('Salvar'),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              ),
            ]
        ),
      ),
    );
  }


  getTiposVacinas() async {

    List tipoVacinas = await DBHelper.instance.getAllTiposVacinas();
    _listaTiposVacinas = tipoVacinas;
    setState(() {
      _listaTiposVacinas;
    });
  }


  clearControllers() {
    _dataController.clear();
  }

  _selectedItemTipoVacina(selectedTipo) {
    setState(() {
      selectedItemTipoVacina = selectedTipo;

      print(selectedItemTipoVacina.id);
      //print(selectedItemTipoVacina['descricao']);

    });
  }



  _cadastrarVacina(ScreenArgumentsVacina args) async {

    bool vacinaPadraoOrOutra = args.vacinaPadraoOrOutra;
    String doseVacina = args.data.dose;
    String petId = args.data.petId;

    DBHelper.instance.addVacina(Vacina(nomeVacina: selectedItemTipoVacina.descricao, dose: doseVacina, petId: petId));

    clearControllers();
    Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");
  }

  bool validateVacina() {
    bool flag = true;

    if (_dataController.text.isEmpty) return false;
    if (selectedItemTipoVacina == null) return false;

    return flag;
  }


  widgetTipoVacinaPadraoOrNova(bool? vacinaPadraoOrOutra) {

    if(vacinaPadraoOrOutra == false){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<dynamic>(
          mode: Mode.MENU,
          items: _listaTiposVacinas.map((tv) => tv).toList(),
          itemAsString: (dynamic tv) =>
              tv.nomeVacina.toString(),
          showSearchBox: true,
          label: "Vacina",
          hint: "escolha a vacina ",
          onChanged: (tipoVacina) {
            _selectedItemTipoVacina(tipoVacina);
          },
        ),
      );

  }else{
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 8),
        child: TextFormField(
          readOnly: true,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(1900),
                lastDate: DateTime(2040));
            if (newDate == null) return;
            setState(() {
              date = newDate;
              _dataController.value = TextEditingValue(
                  text: Utils.formatarDateTime(date));
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
  }

  widgetDosePadraoOrNova(ScreenArgumentsVacina args, bool? vacinaPadraoOrOutra) {

    if(vacinaPadraoOrOutra == false){
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(Utils.showDose(args.data?.dose),
          style: AppTextStyles.vacinaDose,),
      );
    }
  }


  }




