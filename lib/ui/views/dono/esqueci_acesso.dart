
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/database/db_helper.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../api/email.dart';
import '../../components/widgets/appbar/app_bar_dono.dart';
import '../../models/dono.dart';
import '../../utils/core/app_text_styles.dart';
import '../../utils/metods/utils.dart';
import '../screen_arguments/ScreenArgumentsDono.dart';

class EsqueciAcesso extends StatefulWidget {
  const EsqueciAcesso({Key? key}) : super(key: key);

  @override
  State<EsqueciAcesso> createState() => _EsqueciAcessoState();
}

class _EsqueciAcessoState extends State<EsqueciAcesso> {


  String _text = '';
  final _cpfController = TextEditingController();
  final _userController = TextEditingController();
  int qtd = 1;
  bool obscured = true;
  bool _flag = false;
  late FocusNode _myFocusNodeCpf;
  late FocusNode _myFocusNodeEmail;
  //var email = SendEmail('matheushard2013@gmail.com', 'bonjovi6630000');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _myFocusNodeCpf = FocusNode();
    _myFocusNodeEmail = FocusNode();
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
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                     if (_formKey.currentState!.validate()){
                                        //_sendEmail();
                                        _sendEmaill(_cpfController.text, _userController.text);

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
                                            const Icon(Icons.email_outlined),
                                            Container(
                                              width: 150,
                                              height: 50,
                                              alignment: Alignment.center,
                                              child:

                                              Text('Enviar', style: AppTextStyles.titleLogin,),


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
    _cpfController.clear();
    _userController.clear();

  }

  widgetFlagCpfOrEmail(){
    /**SEXO DO PET**/
   return  Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: SwitchListTile(
        title: const Text('Tipo de Envio'),
        value: _flag,
        activeColor: Colors.pink,
        inactiveThumbColor: Colors.blue,
        inactiveTrackColor: Colors.lightBlueAccent,

        onChanged: (bool value) {
          setState(() {
            _flag = value;
          });
        },
        subtitle: const Text("E-mail ou Cpf"),
        secondary: const Icon(
            Icons.pets_sharp, color: Colors.blue),
      ),
    );
  }
  widgetCpfOrEmailDono(bool flagCpfOrEmail){

    ///Cpf habilitado:
    if(flagCpfOrEmail){
    _userController.clear();
    return
      Column(
        children: [
      Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 15),
          child: TextFormField(
          maxLength: 11,
          keyboardType: TextInputType.number,
          controller: _cpfController,
          focusNode: _myFocusNodeCpf,
          decoration: const InputDecoration(
          hintText: 'Cpf',
          icon: Icon(Icons.credit_card, color: Colors.blue,)
          ),

        validator: (value) {

        if (value!.isEmpty || value == "") {
          return "Digite o Cpf";
        }
        return null;
    },
    ),
    ),
      Padding(
        padding: const EdgeInsets.symmetric(
        horizontal: 10, vertical: 15),
        child: TextFormField(
        enabled: false,
        keyboardType: TextInputType.emailAddress,
        controller: _userController,
        focusNode: _myFocusNodeEmail,
        decoration: const InputDecoration(
        hintText: 'E-mail',
        icon: Icon(Icons.alternate_email, color: Colors.blue,)
    ),



    ),
    )

      ],);

    ///E-mail Habilitado:
    }else{
      _cpfController.clear();
      return
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 15),
              child: TextFormField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                controller: _cpfController,
                enabled: false,
                focusNode: _myFocusNodeCpf,
                decoration: const InputDecoration(
                    hintText: 'Cpf',
                    icon: Icon(Icons.credit_card, color: Colors.blue,)
                ),


              ),
            ),
            ///E-mail
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 15),
              child: TextFormField(

                keyboardType: TextInputType.emailAddress,
                controller: _userController,
                focusNode: _myFocusNodeEmail,
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
            )

          ],);

    }
  }


  void _sendEmaill(String cpf, String email) async {

    Dono? donoExists = await DBHelper.instance.getDono(_cpfController.text, _userController.text);
    if(donoExists != null) {
      ///Generate codigo de recuperação
      String codigo = Random().nextInt(9999).toString().padLeft(4, '0');
      ///Update Dono, setar codigo:
      donoExists.codigoRecuperacao = codigo;
      var res= await DBHelper.instance.updateDono(donoExists);
      if(res == 1) {
        SendEmail(donoExists).sendTwilioEmail();
      }else{

      }
    }
    //Utils.showDefaultSnackbar(context, result);
    // _text = result ? 'Enviado.' : 'Não enviado.';
  }



  Future<void> _sendEmail() async {
    List<String> attachments = [];
    print("object init");

    var donoExists = await DBHelper.instance.getDono(_cpfController.text, _userController.text);
    if(donoExists != null) {
      clearControllers();
      String platformResponse = "";
      print("object");
      //Utils.showDefaultSnackbar(context, "E-mail enviado com sucesso!!!");

      ///Send
      String username = 'matheushard2013@gmail.com';
      String password = 'bonjovi663000';
      const token = '';

     // final smtpServer = gmail(username, password);
      final smtpServer = gmailSaslXoauth2(username, token);

      // Use the SmtpServer class to configure an SMTP server:
      // final smtpServer = SmtpServer('smtp.domain.com');
      // See the named arguments of SmtpServer for further configuration
      // options.

      // Create our message.
      final message = Message()
        ..from = Address(username)
        ..recipients.add('crisneri39@gmail.com')
       /// ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
        ///..bccRecipients.add(const Address('bccAddress@example.com'))
        ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
        ..text = 'This is the plain text.\nThis is line 2 of the text part.'
        ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: $sendReport');
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }

    }
    print("object fora");

  }
  }






