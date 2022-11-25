import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
import 'package:projeto_pet/ui/utils/core/app_colors.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsPet.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsVacina.dart';

import '../components/widgets/appbar/app_bar_pet.dart';
import '../components/widgets/cards/card_vacina.dart';
import '../models/dose.dart';
import '../utils/core/app_text_styles.dart';

class CartaoDeVacina extends StatefulWidget {
  const CartaoDeVacina({Key? key}) : super(key: key);

  @override
  State<CartaoDeVacina> createState() => _CartaoDeVacinaState();
}

class _CartaoDeVacinaState extends State<CartaoDeVacina> {

  DateTime date = DateTime.now();
  final _dataController = TextEditingController();
  List<Vacina> _vacinas = [];
  List<Dose> _doses = [];
  var selectedItemTipoVacina;
  var selectedItemDose;
  late List _listaTiposVacinas = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool vacinaPadraoOrOutra = false;

  @override
  void initState() {
    _doses = Utils.listaDoses();
    getTiposVacinas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenArgumentsPet? args = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScreenArgumentsPet?;

    _getVacinas(args?.data.id);

    return Scaffold(
      appBar: AppBarPet(args!),
      bottomSheet:

      Padding(

        padding: const EdgeInsets.only(top: 0, right: 0, bottom: 20, left: 20),
        child: Text("Vacinas: ${_vacinas.length}", style: AppTextStyles.total),
      ),
      body: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children:
          List.generate(_vacinas.length, (index) {
            return CardVacina(
                data: _vacinas[index], onTap: (data) {
            });
          })
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          showInformationDialog(context, args);
        },
      ),
    );
  }

   _getVacinas(String petId) async {

     List<Vacina> list = await DBHelper.instance.getAllVacinasByPet(petId);
     _vacinas = list;
     setState(() {
        _vacinas;
      });
    }
  ///DIALOG CADASTRO VACINA:
  Future<void> showInformationDialog(BuildContext context, ScreenArgumentsPet argsPet) async {

    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cadastro Vacina",),
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
                                        child: Text("argsVacina.data.nomeVacina.toUpperCase()", style: AppTextStyles.vacinaNome,),
                                      ),
                                      ///Add Vacina Nova:
                                      widgetTipoVacinaNova(),
                                      widgetDoseNova(),
                                      widgetDataAplicacao()

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
                 _cadastrarVacina(argsPet!, context);
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

  widgetTipoVacinaNova() {

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<dynamic>(
          mode: Mode.MENU,
          items: _listaTiposVacinas.map((tv) => tv).toList(),
          itemAsString: (dynamic tv) =>
              tv.nomeVacina.toString(),
          showSearchBox: true,
          label: "Menu Vacina",
          hint: "escolha a vacina ",
          onChanged: (tipoVacina) {
            _selectedItemTipoVacina(tipoVacina);
          },
        ),
      );
  }
  widgetDoseNova() {

     return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
       DropdownSearch<Dose>(
        mode: Mode.MENU,
         items: _doses.map((d) => d).toList(),
        itemAsString: (dynamic d) => d.descricao.toString(),
       showSearchBox: true,
        label: "Menu mode",
        hint: "country in menu mode",
        onChanged: (obj) {
          _selectedItemDose(obj);

        },
        //selectedItem: "Escolha a Dose",
      ),
    );

  }

  widgetDataAplicacao() {

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

  clearControllers() {
    selectedItemTipoVacina = null;
    selectedItemTipoVacina = null;
    _dataController.clear();
  }
    getTiposVacinas() async {

    List tipoVacinas = await DBHelper.instance.getAllTiposVacinas();
    _listaTiposVacinas = tipoVacinas;
    setState(() {
      _listaTiposVacinas;
    });
  }


  _selectedItemTipoVacina(selectedTipo) {
    setState(() {
      selectedItemTipoVacina = selectedTipo;
      print(selectedItemTipoVacina);

    });
  }
  _selectedItemDose(selectedDose) {
    setState(() {
      selectedItemDose = selectedDose;
      print(selectedItemDose.descricao);

    });
  }

  _cadastrarVacina(ScreenArgumentsPet args, BuildContext context) async {

    String petId = args.data.id;
    DBHelper.instance.addVacina(
                          Vacina(nomeVacina: selectedItemTipoVacina.nomeVacina,
                                dose: selectedItemDose.dose, petId: petId, dataAplicacao: date.toString()));
    clearControllers();
    Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");
    Navigator.pop(context, 'Cancel');

  }

  bool validateVacina() {
    bool flag = true;
    if (selectedItemDose == null) return false;
    if (selectedItemTipoVacina == null) return false;
    return flag;
  }

}




