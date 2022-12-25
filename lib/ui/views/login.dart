
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';
import 'package:projeto_pet/ui/views/home.dart';
import 'package:projeto_pet/ui/views/screen_arguments/ScreenArgumentsDono.dart';

import '../database/db_helper.dart';
import '../models/dono.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _myFocusNode;
  late FocusNode _myFocusNode_2;
  var donoNew;


  @override
  void initState (){

    _myFocusNode = FocusNode();
    _myFocusNode_2 = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body:
      Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                gradient: AppGradients.sol
            ),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [

                    const Center(
                      child: Text("Login", style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold

                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 30),
                      child: TextFormField(

                        controller: _userController,
                        focusNode: _myFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                            labelText: "Usuario:",
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "digite o usuario",
                            hintStyle: TextStyle(color: Colors.cyan),
                            icon: Icon(Icons.perm_identity , color: Colors.white,)
                        ),
                        validator:  (value){
                          if(value!.isEmpty || value == ""){
                            _myFocusNode.requestFocus();
                            return "Digite o Usuario";
                          }
                          return null;
                        },

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,

                        focusNode: _myFocusNode_2,
                        keyboardType: TextInputType.text,

                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "Senha:",
                            hintText: "digite a senha",
                            hintStyle: TextStyle(color: Colors.cyan),
                            icon: Icon(Icons.lock_open, color: Colors.white,)
                        ),
                        validator:  (value){
                          if(value!.isEmpty || value == ""){
                            _myFocusNode.requestFocus();
                            return "Digite a Senha";
                          }
                          return null;
                        },
                      ),
                    ),
                    /*************BUTTON***************/

                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()) {
                                  _logar(context);
                                  //print("logado");

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

                                          Text(
                                            'Acessar',
                                            style: AppTextStyles.titleLogin,
                                          ),


                                        ),
                                      ],)
                                )
                            )
                        )),
                    /***************FIM*****************/
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: (){
                              setState(() {
                                Navigator.popAndPushNamed(context, '/cadastro_dono', arguments: ScreenArgumentsDono(null));

                              });

                              },
                          child:  Text("novo cadastro", style: AppTextStyles.loginNovoEsqueci)
                          ),
                          TextButton(
                              onPressed: (){
                                setState(() {
                                  Navigator.popAndPushNamed(context, '/esqueci_acesso');

                                });
                              },
                          child:  Text("esqueci a senha", style: AppTextStyles.loginNovoEsqueci)
                          ),
                        ],
                      ),
                    )

                  ],)),
          ),
        ),
      ),
    );
  }

 Future _logar(BuildContext context) async{
   
    String email = "";
    String cpf = "";
    if(!Utils.invalidEmail(_userController.text)){
      email = _userController.text;
    }
    if(Utils.validarCPF(_userController.text)){
      cpf = _userController.text;

    }

    var senha = Utils.toSha1(_passwordController.text);

    Dono? tutor = await DBHelper.instance.getDonoLogin(cpf, email, senha);

    if(tutor == null) {
     Utils.showDefaultSnackbar(context, "Verifique suas Credencias!!!");
    }else{
          setState(() {
            Navigator.popAndPushNamed(
                context,
                '/home',
                arguments: ScreenArgumentsDono(tutor)
            );
          });
        }

      }
  clearControllers(){
    _userController.clear();
    _passwordController.clear();
  }
  Future<bool> donoExists(var tutor) async {

    bool flag = false;
    if(tutor.isEmpty){
      flag = true;
    }
    return flag;
  }


}
