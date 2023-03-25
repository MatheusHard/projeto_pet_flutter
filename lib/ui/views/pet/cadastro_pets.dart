

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_pet/ui/components/exemplo.dart';
import 'package:projeto_pet/ui/components/widgets/appbar/app_bar_pet.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/models/vacina.dart';
import 'package:projeto_pet/ui/utils/core/app_colors.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_images.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

import '../../components/widgets/appbar/app_bar_cadastro_pet.dart';
import '../../models/pet.dart';
import '../screen_arguments/ScreenArgumentsDono.dart';
import '../screen_arguments/ScreenArgumentsPet.dart';


class CadastroPets extends StatefulWidget {

  final pet;
  const CadastroPets({@required this.pet, Key? key}) : super(key: key);

  @override
  State<CadastroPets> createState() => _CadastroPetsState();
}

class _CadastroPetsState extends State<CadastroPets> {

  DateTime? date;
  DateTime initialDate = DateTime.now();


  final _picker = ImagePicker();
  var selectedItemTipoPet;
  late List _listaTiposPets = [];
  late List _listaTiposVacinas = [];
  bool flagEditarPet = false;

  final _nomeController = TextEditingController();
  late var _dataController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _selectedFile;
  bool _sexo = false;
  String nome = "";
  var _tutor;
  late var pet;


  @override
  void initState() {
    getTipos();
    getTiposVacinas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ///Arguments
    ScreenArgumentsPet? args = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScreenArgumentsPet?;

    _tutor = args?.dataTutor;
    flagEditarPet = args?.flagEditarPet;
    _initControllers(args?.data);


    return Scaffold(
      appBar: AppBarCadastroPet(args),
      body: Form(
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
                          const SizedBox(
                            height: 50,
                            width: 50,
                          ),

                          /******NOME PET******/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: TextFormField(

                              keyboardType: TextInputType.text,
                              controller: _nomeController,
                              decoration: const InputDecoration(
                                  hintText: 'Nome do Pet',
                                  icon: Icon(Icons.pets, color: Colors.green,)
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  //_myFocusNode.requestFocus();
                                  return "Digite o Nome do Pet";
                                }
                                return null;
                              },
                            ),
                          ),
                          /*********DATA NASCIMENTO**********/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2040));
                                if (newDate == null) return;
                                setState(() {
                                  date = newDate;
                                  _dataController.value = TextEditingValue(

                                      text: _dataInput(args?.data));
                                });
                              },
                              keyboardType: TextInputType.text,
                              controller: _dataController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.date_range, color: Colors.green),
                                hintText: "Data de Nascimento",
                              ),
                              validator: (value) {
                                if (value == null || value == "") {
                                  // _myFocusNode.requestFocus();
                                  return "Data de Nascimento Obrigatória!!!";
                                }
                                return null;
                              },
                            ),

                          ),
                          /**SEXO DO PET**/
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: SwitchListTile(
                              title: const Text('Sexo'),
                              value: _sexo,
                              activeColor: Colors.pink,
                              inactiveThumbColor: Colors.blue,
                              inactiveTrackColor: Colors.lightBlueAccent,

                              onChanged: (bool value) {
                                setState(() {
                                  _sexo = value;
                                });
                              },
                              subtitle: const Text("Macho ou Fêmea"),
                              secondary: const Icon(
                                  Icons.pets_sharp, color: Colors.green),
                            ),
                          ),
                          /**TIPO DO PET**/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownSearch<dynamic>(
                              mode: Mode.MENU,
                              items: _listaTiposPets.map((tp) => tp).toList(),
                              itemAsString: (dynamic tp) => tp['descricao'].toString(),
                              showSearchBox: true,
                              dropdownSearchDecoration: const InputDecoration(
                                labelText: 'Tipo do Pet',
                                hintText: 'escolha o tipo'
                              ),
                              onChanged: (tipoPet) {
                                _changeItemTipoPet(tipoPet);
                              },
                              selectedItem: _selectedItemTipoPetSelected(args?.data),
                            ),

                          ),

                          /*****CAMERA PICTURE/GALLERY*****/
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, top: 20),
                                    child: Text("Cadastre a Imagem da Conta",
                                        style: AppTextStyles.heading15),
                                  ),
                                  getImageWidget(),
                                  ///***********************/
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      /*********CAMERA BUTTON*********/
                                      Expanded(
                                          child:
                                          GestureDetector(

                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(50)),
                                                height: 70,
                                                width: 70,
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [

                                                    const Center(child:
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: AppColors.black,
                                                      size: 35,),),

                                                    Align(
                                                        alignment: const Alignment(
                                                            0, 2.0),
                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(bottom: 20),
                                                          child: Text("Camera",
                                                            style: AppTextStyles
                                                                .bodyBold,),
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),

                                              onTap: () {
                                                _getImage(ImageSource.camera);
                                              } //
                                          )),

                                      /*********GALERIA BUTTON*********/

                                      Expanded(
                                          child:
                                          GestureDetector(

                                              child: Container(

                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(50)),
                                                height: 70,
                                                width: 70,
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [

                                                    const Center(child:
                                                    Icon(
                                                      Icons.image_rounded,
                                                      color: AppColors.black,
                                                      size: 35,),),

                                                    Align(
                                                        alignment: const Alignment(
                                                            0, 2.0),
                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(bottom: 20),
                                                          child: Text("Galeria",
                                                            style: AppTextStyles
                                                                .bodyBold,),
                                                        ))
                                                  ],
                                                ),
                                              ),

                                              onTap: () {
                                                _getImage(ImageSource.gallery);
                                              } //
                                          )

                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),


                          /***SALVAR PET***/
                        Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                              child: Center(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() && validatePet()) {
                                          _cadastrarPet(args);
                                        } else {
                                          Utils.showDefaultSnackbar(
                                              context, "Não foi possivel salvar!!!");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20))),
                                      child: Ink(

                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(colors:
                                              [
                                                Color(0xFF57B6E5),
                                                Color.fromRGBO(130, 87, 229, 0.695),
                                              ]),
                                              borderRadius: BorderRadius.circular(20)),
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.save_rounded),
                                              Container(
                                                width: 150,
                                                height: 50,
                                                alignment: Alignment.center,
                                                child:

                                                Text('Salvar', style: AppTextStyles.titleLogin,),


                                              ),
                                            ],)
                                      )
                                  )
                              )),
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

  getTipos() async {
    List tipoPets = await DBHelper.instance.getAllTiposPets();
    //Iterable<TipoPet> tipoPets =    await DBHelper.instance.gelAllTiposPet2();

    _listaTiposPets = tipoPets;
    setState(() {
      _listaTiposPets;

    });

  }

  getTiposVacinas() async {
    List tipoVacinas = await DBHelper.instance.getAllTiposVacinas();
    _listaTiposVacinas = tipoVacinas;
    setState(() {
      _listaTiposVacinas;
    });
  }


  clearControllers() {
    _nomeController.clear();
    _dataController.clear();
  }
  _initControllers(Pet? data) async{
    if(data != null) {
        _sexo = data.sexo;
        _dataController.text = _dataInput(data);
        // _selectedItemTipoPet(data.tipoPet);

        _nomeController.text = data.nome;

        //_dataController.text = data.;


    }
  }
    _selectedItemTipoPetSelected(var data) {

    if(selectedItemTipoPet != null){
      return selectedItemTipoPet;
    }else if(data is Pet) {
      var tipoPet =  {"id": data.tipoPet, "descricao": data.descricaoTipoPet};
      selectedItemTipoPet = tipoPet;
        return tipoPet;
    } else {
        return data;
    }

  }


  _changeItemTipoPet(selectedTipo) {
    setState(() {
      selectedItemTipoPet = selectedTipo;
      _selectedItemTipoPetSelected(selectedItemTipoPet);

    });
  }

  Future _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(
        source: source,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _selectedFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile!,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        AppImages.no_image,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  _cadastrarPet(var args) async {


    //Atualizar Pet
    if(flagEditarPet) {
      String file;
      String id;
      nome = _nomeController.text.toString();
      file = Utils.base64String(_selectedFile!.readAsBytesSync());
      id = args.data.id;
      DBHelper.instance.updatePet(
          Pet(
              id: id,
              donoPet: _tutor.id,
              nome: nome,
              tipoPet: selectedItemTipoPet['id'],
              sexo: _sexo,
              dataNascimento: date.toString(),
              imagePet: file));

      clearControllers();
      Utils.showDefaultSnackbar(context, "Atualizado com sucesso!!!");

      Navigator.pushNamed(
          context, '/home', arguments: ScreenArgumentsDono(args.dataTutor));

    //Cadastrar Pet
    }else{
      String file;
      String id;
      nome = _nomeController.text.toString();
      file = Utils.base64String(_selectedFile!.readAsBytesSync());
      id = Utils.generateGuide();
      DBHelper.instance.addPet(
          Pet(
              id: id,
              donoPet: _tutor.id,
              nome: nome,
              tipoPet:  selectedItemTipoPet['id'],

              sexo: _sexo,
              dataNascimento: date.toString(),
              imagePet: file));

      cadastrarVacinasPadrao(id);
      clearControllers();
      Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");

      Navigator.pushNamed(
          context, '/home', arguments: ScreenArgumentsDono(args.dataTutor));
    }

  }
  void cadastrarVacinasPadrao(String idPet) async{
    print("Cadastros das Vacinas PAdrao");
    ///Poli
    await DBHelper.instance.addVacina(Vacina(nomeVacina: "Polivalente V10", dose: 'D1', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(nomeVacina: "Polivalente V10",  dose: 'D2', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(nomeVacina: "Polivalente V10",  dose: 'D3', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(nomeVacina: "Polivalente V10",  dose: 'D4', petId: idPet));

    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Antirrabica",  dataAplicacao: null, dose: 'D1', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Antirrabica",  dataAplicacao: null, dose: 'REF', petId: idPet));

    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Gripe",  dataAplicacao: null, dose: 'D1', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Gripe",  dataAplicacao: null, dose: 'REF', petId: idPet));

    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Giardia",  dataAplicacao: null,dose: 'D1', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Giardia",  dataAplicacao: null, dose: 'REF',petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Visceral",  dataAplicacao: null,dose: 'D1', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Visceral",  dataAplicacao: null,dose: 'REF', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Tegumentar",  dataAplicacao: null,dose: 'D1', petId: idPet));
    await DBHelper.instance.addVacina(Vacina(dataCadastro: null, nomeVacina: "Leishmaniose Tegumentar",  dataAplicacao: null,dose: 'REF', petId: idPet));

    print(" FIM Cadastros das Vacinas PAdrao");



  }

  bool validatePet() {
    bool flag = true;

    if (_nomeController.text.isEmpty) return false;
    if (_dataController.text.isEmpty) return false;

    if (_selectedFile == null) return false;
    if (selectedItemTipoPet == null) return false;

    return flag;
  }

  _dataInput(data) {

  if(date != null){
    return  Utils.formatarDateTime(date);
  }else if(data != null){
    date =  DateTime.tryParse(data.dataNascimento);
    return Utils.formatarData(data.dataNascimento, true);
  }
  }

}
