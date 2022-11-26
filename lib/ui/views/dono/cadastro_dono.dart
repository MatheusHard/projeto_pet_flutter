
import 'dart:developer';
import 'package:counter/counter.dart';

import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsDono.dart';

import '../../components/widgets/appbar/app_bar_dono.dart';

class CadastroDono extends StatefulWidget {
  const CadastroDono({Key? key}) : super(key: key);

  @override
  State<CadastroDono> createState() => _CadastroDonoState();
}

class _CadastroDonoState extends State<CadastroDono> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _qtdRowController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ScreenArgumentsDono? argsDono = ModalRoute
        .of(context)
        ?.settings
        .arguments as ScreenArgumentsDono?;

    ///    vacinaPadraoOrOutra = argsVacina?.vacinaPadraoOrOutra!;

    return Scaffold(
      appBar: AppBarDono(null),
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
                              "Dados", style: AppTextStyles.titlePet,),
                          ),

                          /******NOME DONO******/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: TextFormField(

                              keyboardType: TextInputType.text,
                              controller: _nomeController,
                              decoration: const InputDecoration(
                                  hintText: 'Nome do Dono',
                                  icon: Icon(Icons.person, color: Colors.blue,)
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  //_myFocusNode.requestFocus();
                                  return "Digite o Nome do Dono";
                                }
                                return null;
                              },
                            ),
                          ),
                          /******CPF DONO******/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: TextFormField(

                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              controller: _cpfController,
                              decoration: const InputDecoration(
                                  hintText: 'Cpf',
                                  icon: Icon(Icons.credit_card, color: Colors.blue,)
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  //_myFocusNode.requestFocus();
                                  return "Digite o Cpf";
                                }
                                return null;
                              },
                            ),
                          ),
                          /******LOGIN/USER DONO******/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: TextFormField(


                              keyboardType: TextInputType.emailAddress,
                              controller: _userController,
                              decoration: const InputDecoration(
                                  hintText: 'Login/Email',
                                  icon: Icon(Icons.alternate_email, color: Colors.blue,)
                              ),

                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  //_myFocusNode.requestFocus();
                                  return "Digite o Email";
                                }
                                return null;
                              },
                            ),
                          ),
                          Counter(
                              min: 0,
                              max: 3,
                              bound: 1,
                              step: 1,
                              onValueChanged:  (value){
                                //_qtdRowController.value = value;
                              },
                            ),




                          ///SALVAR DONO
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    validateDono()) {
                                  _cadastrarDono();
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





  clearControllers() {
    _nomeController.clear();
    _cpfController.clear();
    _passwordController.clear();
    _qtdRowController.clear();
    _userController.clear();

  }




  _cadastrarDono() async {

    //bool vacinaPadraoOrOutra = args.vacinaPadraoOrOutra;
    //String doseVacina = args.data.dose;
    //String petId = args.data.petId;

    //DBHelper.instance.addVacina(Vacina(nomeVacina: selectedItemTipoVacina.descricao, dose: doseVacina, petId: petId));

    clearControllers();
    Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");
  }

  bool validateDono() {
    bool flag = true;

    if (_nomeController.text.isEmpty) return false;
    if (_cpfController.text.isEmpty) return false;
    if (_qtdRowController.text.isEmpty) return false;
    if (_passwordController.text.isEmpty) return false;

    return flag;
  }



  }






