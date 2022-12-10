
import 'dart:developer';
import 'package:counter/counter.dart';

import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:projeto_pet/ui/models/dono.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsDono.dart';

import '../../components/widgets/appbar/app_bar_dono.dart';

class CadastroDono extends StatefulWidget {
  final ScreenArgumentsDono tutor;

  const CadastroDono({Key? key, required this.tutor}) : super(key: key);

  @override
  State<CadastroDono> createState() => _CadastroDonoState();
}

class _CadastroDonoState extends State<CadastroDono> {

  final _nomeController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  final _cpfController = TextEditingController();
  final _qtdRowController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = TextEditingController();
  int qtd = 1;
  bool obscured = true;


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

    _initControllers(argsDono?.data);

    return Scaffold(
      appBar: AppBarDono(null),
      body:  Form(
        key: _formKey,
        child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: SingleChildScrollView(

                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Text(
                            "Dados", style: AppTextStyles.titlePet,),
                        ),
                        /******NOME DONO******/
                        widgetNomeDono(),
                        /******CPF DONO******/
                        widgetCpfDono(),
                        /******User/Email DONO******/
                        widgetUser(),
                        ///Password
                        widgetSenha(),
                        ///Qtd Listagem
                        widgetQtdListagem(argsDono?.data),
                        ///Salvar
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            child: Center(
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
  widgetCpfDono(){
    return   Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 15),
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
    );
  }

  widgetQtdListagem(var args){

    return   Padding(
      padding: const EdgeInsets.only(top: 30, right: 10, bottom: 30, left: 10),

      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 0, bottom: 0,right: 15, top: 0),
            child: Icon(Icons.list_outlined, color: Colors.blue,),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0, bottom: 0,right: 15, top: 0),
            child: Text("Tamanho da Listagem", ),
          ),
          Counter(
            min: 1,
            max: 3,
            initial: (args.data.qtdRowListagem != null) ?  args.data.qtdRowListagem : 2,
            bound: 1,
            step: 1,

            configuration: DefaultConfiguration(),
            onValueChanged:  (value){
              qtd = value.toInt();
              print(qtd);
              //_qtdRowController.value = value;
            },
          ),

        ],),
    );

  }
  widgetUser(){
    return  Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 15),
      child: TextFormField(

        keyboardType: TextInputType.emailAddress,
        controller: _userController,
        decoration: const InputDecoration(
            hintText: 'Login/Email',
            icon: Icon(Icons.alternate_email, color: Colors.blue,)
        ),

        validator: (value) {
          if (value!.isEmpty || value == "") {
            return "Digite o Email";
          }
          if(Utils.invalidEmail(value)){
            return "Email inválido!!!";
          }
          return null;
        },
      ),
    );
  }

_initControllers(var args){

  if(args.data != null) {
    _nomeController.text = args.data.nome;
    _userController.text = args.data.user;
    _cpfController.text = args.data.cpf;
    _passwordController.text = args.data.password;
  }

}
widgetNomeDono(){

    return   Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 15),
      child: TextFormField(

        keyboardType: TextInputType.text,
        controller: _nomeController,
        decoration: const InputDecoration(
            hintText: 'Nome do Dono',
            icon: Icon(Icons.person, color: Colors.blue,)
        ),
        validator: (value) {
          if (value!.isEmpty || value == "") {
            return "Digite o Nome do Dono";
          }
          return null;
        },
      ),
    );
}

widgetSenha(){

  return Padding(
    padding: const  EdgeInsets.symmetric(vertical: 15, horizontal: 0),
    child: TextFormField(
      keyboardType: TextInputType.visiblePassword,

      obscureText: obscured,
      focusNode: textFieldFocusNode,
      controller: _passwordController,

      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: "Senha",
        filled: true, // Needed for adding a fill color
        fillColor: Colors.white60,
        isDense: true,  // Reduces height a bit
        border: OutlineInputBorder(
          borderSide: BorderSide.none,              // No border
          borderRadius: BorderRadius.circular(12),  // Apply corner radius
        ),
        prefixIcon: const Icon(Icons.lock_rounded, size: 24),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              obscured
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              size: 24,
            ),
          ),
        ),
      ),
      validator:  (value) {
        if (value!.isEmpty || value == "") {
          //_myFocusNode.requestFocus();
          return "Digite a Senha";
        }
        return null;
      }
    ),
  );

}

  void _toggleObscured() {
    setState(() {
      obscured = !obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  Future<bool> donoExists() async {

    bool flag = false;
    List donoExists = await DBHelper.instance.getDonoByCpfOrUser(_cpfController.text, _userController.text);
    if(donoExists.isNotEmpty){
      flag = true;
    }
    return flag;
  }


  _cadastrarDono() async {

    if(!await donoExists()) {
      DBHelper.instance.addDono(Dono(nome: _nomeController.text,
          cpf: _cpfController.text,
          user: _userController.text,
          password: _passwordController.text,
          qtdRowListagem: qtd));
      clearControllers();
      Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushNamed(context, '/login');
      });

    }else{
      Utils.showDefaultSnackbar(context, "Erro, usuário já existe no Sistema!!!");
    }

    //}else if(dono.isNotEmpty){
      //Utils.showDefaultSnackbar(context, "Cadastro realizado com sucesso!!!");

    //}
  }

  ///Validações:
  bool validateDono() {
    bool flag = true;

    if (_nomeController.text.isEmpty) return false;
    if (_cpfController.text.isEmpty) return false;
    if (_passwordController.text.isEmpty) return false;
    if (_userController.text.isEmpty) return false;
    if (qtd.isNaN || qtd.isNegative) return false;

    return flag;
  }



  }






