

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_pet/ui/components/exemplo.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/tipo_pet.dart';
import 'package:projeto_pet/ui/utils/core/app_colors.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_images.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

import 'models/pet.dart';


class CadastroPets extends StatefulWidget {
  const CadastroPets({Key? key}) : super(key: key);

  @override
  State<CadastroPets> createState() => _CadastroPetsState();
}

class _CadastroPetsState extends State<CadastroPets> {

  DateTime date = DateTime.now();

  final _picker = ImagePicker();
  var selectedItemTipoPet;
  late List _listaTiposPets = [];
  late FocusNode _myFocusNodeNome;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nomeController = TextEditingController();
  final _dataController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _selectedFile;
  bool _sexo = false;
  String nome = "";



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
      child: Stack(
        children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(

            child:  SingleChildScrollView(

          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text("Cadastrar Pet", style: AppTextStyles.titlePet,),
            ),
              /******NOME PET******/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextFormField(

                    keyboardType: TextInputType.text,
                    controller: _nomeController,
                    decoration: const InputDecoration(
                        hintText: 'Nome do Pet',
                        icon: Icon(Icons.pets, color: Colors.green,)
                    ),

                    validator:  (value){
                      if(value!.isEmpty || value == ""){
                        //_myFocusNode.requestFocus();
                        return "Digite o Nome do Pet";
                      }
                      return null;
                    },
                  ),
                ),
                /*********DATA NASCIMENTO**********/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async{
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2040));
                      if(newDate == null) return;
                      setState(() {
                        date = newDate;
                        _dataController.value = TextEditingValue(text:  Utils.formatarDateTime(date) );

                      });
                    },
                    keyboardType: TextInputType.datetime,
                    controller: _dataController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.date_range, color: Colors.green),
                      hintText :  "Data de Nascimento",
                    ),

                    validator:  (value){
                      if(value == null || value == ""){
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
                      print(_sexo);
                    });
                  },
                  subtitle: const Text("Macho ou Fêmea"),
                  secondary: const Icon(Icons.pets_sharp, color: Colors.green),
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
                    label: "Tipo do Pet",
                    hint: "escolha o tipo",
                    onChanged: (tipoPet) {
                       //print(tipoPet);
                       _selectedItemTipoPet(tipoPet);

                    },
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
                          padding: const EdgeInsets.only(bottom: 15, top: 20),
                          child: Text("Cadastre a Imagem da Conta",
                              style: AppTextStyles.heading15),
                        ),
                        getImageWidget(),

                        ///***********************/
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,

                          children: [

                            /*********CAMERA BUTTON*********/
                            Expanded(
                                child:
                                GestureDetector(

                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50)),
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
                                              alignment: const Alignment(0, 2.0),
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 20),
                                                child: Text("Camera", style: AppTextStyles.bodyBold,),
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
                                      borderRadius: BorderRadius.circular(50)),
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
                                              alignment: const Alignment(0, 2.0),
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 20),
                                                child: Text("Galeria", style: AppTextStyles.bodyBold,),
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
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && validatePet()) {
                        _cadastrarPet();
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
        )
          ),]
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
    _dataController.clear();

  }
  _selectedItemTipoPet(selectedTipo){
    setState(() {
      selectedItemTipoPet = selectedTipo;
      print(selectedItemTipoPet['id']);
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
  Widget getImageWidget(){
    if(_selectedFile != null){
      return Image.file(
        _selectedFile!,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }else{
      return Image.asset(
        AppImages.no_image,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }


  }
  _cadastrarPet() async{
    String file;

    setState(() {

      nome = _nomeController.text.toString();
      file = Utils.base64String(_selectedFile!.readAsBytesSync());

      DBHelper.instance.addPet(
                            Pet(
                                donoPet: 1, nome: nome, tipoPet: selectedItemTipoPet['id'],
                                sexo: _sexo, dataNascimento: date.toString(), imagePet: file));

      clearControllers();
      Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");
    });
  }

  bool validatePet(){
    bool flag = true;

    if(_nomeController.text.isEmpty) return false;
    if(_dataController.text.isEmpty) return false;

    if(_selectedFile == null) return false;
    if(selectedItemTipoPet == null) return false;

    return flag;

  }

  }

