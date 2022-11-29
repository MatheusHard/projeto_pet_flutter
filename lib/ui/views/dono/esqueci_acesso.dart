
import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';

import '../../components/widgets/appbar/app_bar_dono.dart';
import '../../utils/core/app_text_styles.dart';
import '../../utils/metods/utils.dart';
import '../screen_arguments/ScreenArgumentsDono.dart';

class EsqueciAcesso extends StatefulWidget {
  const EsqueciAcesso({Key? key}) : super(key: key);

  @override
  State<EsqueciAcesso> createState() => _EsqueciAcessoState();
}

class _EsqueciAcessoState extends State<EsqueciAcesso> {

  final _cpfController = TextEditingController();
  final _userController = TextEditingController();
  int qtd = 1;
  bool obscured = true;
  bool _flag = false;

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
                        ///Chave escolha Cpf ou Email
                        widgetFlagCpfOrEmail(),
                        ///Exibir Email ou Cpf:
                        widgetCpfOrEmailDono(_flag),

                        ///Enviar
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()){
                                _sendEmail();

                            }},
                            child: const Text('Enviar'),
                          ),
                        ),


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
    _cpfController.clear();
    _userController.clear();

  }

  widgetFlagCpfOrEmail(){
    /**SEXO DO PET**/
   return  Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: SwitchListTile(
        title: const Text('Sexo'),
        value: _flag,
        activeColor: Colors.pink,
        inactiveThumbColor: Colors.blue,
        inactiveTrackColor: Colors.lightBlueAccent,

        onChanged: (bool value) {
          setState(() {
            _flag = value;
          });
        },
        subtitle: const Text("Macho ou Fêmea"),
        secondary: const Icon(
            Icons.pets_sharp, color: Colors.green),
      ),
    );
  }
  widgetCpfOrEmailDono(bool flagCpfOrEmail){
    ///Cpf
    if(flagCpfOrEmail){
    _userController.clear();
    return Padding(
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
    ///E-mail
    }else{
      _cpfController.clear();
      return  Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 15),
        child: TextFormField(

          keyboardType: TextInputType.emailAddress,
          controller: _userController,
          decoration: const InputDecoration(
              hintText: 'E-mail',
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
  }



  Future<void> _sendEmail() async {
    List<String> attachments = [];

    var donoExists = await DBHelper.instance.getDono(_cpfController.text, _userController.text);
    if(donoExists != null ){
      clearControllers();
      String platformResponse = "";

      //Utils.showDefaultSnackbar(context, "E-mail enviado com sucesso!!!");

      /*final Email email = Email(
        body: '''Senha: ${donoExists.password}''',
        subject: "_subjectController.text",
        recipients: [donoExists.user],
        attachmentPaths: attachments,
        isHTML: false,
      );
      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        print(error);
        platformResponse = error.toString();
      }*/

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(platformResponse),
        ),
      );
    }else{
      //Utils.showDefaultSnackbar(context, "Usuário não encontrado no Sistema!!!");
    }

  }


}



