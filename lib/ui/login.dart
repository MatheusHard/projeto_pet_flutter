
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/home.dart';
import 'package:projeto_pet/ui/utils/core/app_gradients.dart';
import 'package:projeto_pet/ui/utils/core/app_text_styles.dart';
import 'package:projeto_pet/ui/utils/metods/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


  final TextEditingController _user = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late FocusNode _myFocusNode;
  late FocusNode _myFocusNode_2;

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

      /* appBar: AppBar(
        centerTitle: true,
        title: const Text("Controle de gastos f"),
        backgroundColor: Colors.blue,
      ),*/
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

                  /*  Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/gasto.png'
                            , ),
                        ),),
                    ),*/
                    const Center(
                      child: Text("Login", style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold

                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 50, 30),
                      child: TextFormField(
                        controller: _user,
                        focusNode: _myFocusNode,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Usuario:",
                            hintText: "digite o usuario",
                            icon: Icon(Icons.perm_identity)
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
                        controller: _password,
                        focusNode: _myFocusNode_2,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Senha:",
                            hintText: "digite a senha",
                            icon: Icon(Icons.perm_identity)
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
                                  //if(_formKey.currentState!.validate()) {
                                  _logar(context);
                                  //print("logado");

                                  //}
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
                                      ],)))))
                    /***************FIM*****************/
                  ],)),
          ),
        ),
      ),
    );
  }

  _logar(BuildContext context) async{

    setState(() {
      Utils.showDefaultSnackbar(context, "Tentando Logar");
      Navigator.pushNamed(
        context,
        '/home',
        arguments: ScreenArguments("Matheus")
      );

    });


  }
  clearControllers(){
    _user.clear();
    _password.clear();
  }

}
