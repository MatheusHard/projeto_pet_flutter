

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:projeto_pet/ui/components/exemplo.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';


class CadastroPets extends StatefulWidget {
  const CadastroPets({Key? key}) : super(key: key);

  @override
  State<CadastroPets> createState() => _CadastroPetsState();
}

class _CadastroPetsState extends State<CadastroPets> {


  var selectedItemTipoPet;
  late List _listaTiposPets = [];
  late FocusNode _myFocusNodeNome;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getTipos();
    _myFocusNodeNome = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
          TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite o nome do PET';
                }
                return null;
              },
            ),
            /**TIPO DO PET**/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<dynamic>(
                mode: Mode.MENU,
                items: _listaTiposPets.map((tp) => tp).toList(),
                itemAsString: (dynamic tp) => tp['descricao'].toString(),
                showSearchBox: true,
                label: "TIpo do Pet",
                hint: "escolha o tipo",
                onChanged: (tipoPet) {
                   //print(tipoPet);
                   _selectedItemTipoPet(tipoPet);

                },
              ),
            ),
            /**FIM**/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                   Utils.showDefaultSnackbar(context, "Salvando");

                  }else{
                    Utils.showDefaultSnackbar(context, "Não foi possivel salvar!!!");

                  }
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getTipos() async{

    List tipoPets = await DBHelper.instance.getAllTiposPets();
    _listaTiposPets = tipoPets;
    setState(() {
      _listaTiposPets;
    });
    }



  clearControllers(){
    _nomeController.clear();
  }
  _selectedItemTipoPet(selectedTipo){
    setState(() {
      selectedItemTipoPet = selectedTipo;
      print(selectedItemTipoPet);
    });
  }
}
