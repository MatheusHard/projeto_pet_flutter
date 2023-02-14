import 'dart:convert';
import 'dart:math';

//import 'package:mailer/mailer.dart';
import 'package:flutter/material.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:sendgrid_mailer/sendgrid_mailer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/dono.dart';
import '../utils/metods/utils.dart';
import '../views/screen_arguments/ScreenArgumentsDono.dart';




class SendEmail {
  String? _username;
  var smtpServer;
  Dono? _dono;
  BuildContext? _context;

  SendEmail(Dono? dono, BuildContext? context){
    _dono = dono;
    _context = context;
    }

  void sendTwilioEmail() {

  try{

    var codigo = (_dono?.codigoRecuperacao != null) ? _dono?.codigoRecuperacao: "";
    var key = dotenv.env['API_KEY_TWILIO'];

      var mailer = Mailer(key!);
      var toAddress = Address(_dono!.user);
      var fromAddress = Address('matheushard2013@gmail.com');
      var content = Content('text/plain', '''Código de Verificação -> $codigo''');
      var subject = 'Recuperação de Senha';
      var personalization = Personalization([toAddress]);

      var email = Email([personalization], fromAddress, subject, content: [content]);

      mailer.send(email).then((result) {
        ///Exibir erro:
        if(result.isError) {
          Utils.showDefaultSnackbar(_context!, 'ERRO -> ${result.asError?.error.toString()}');
          print(result.asError?.error.toString());
        }
        if(result.isValue) {
          ///Ir pra tela do código:
               Navigator.pushNamed(
                   _context!,
                   '/esqueci_acesso_validacao',
                   arguments: ScreenArgumentsDono(_dono)
               );
        }

      }).catchError((Error onError) {
        Utils.showDefaultSnackbar(_context!, '''OnErro: ${onError.stackTrace}''');
      });

    }catch(error){
    Utils.showDefaultSnackbar(_context!, '''Error: $error''');
    }
  }



  //Envia um email para o destinatário, contendo a mensagem com o nome do sorteado
  Future sendMessage(String mensagem, String destinatario, String assunto) async {
    const servideId = "service_rf5hgl5";
    const templateId = "template_9glpmrr";
    const userId = "-DHBVmyMzf3wfaLjt";
   final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
   final response = http.post(url,
   headers: {'Content-Type': 'application/json', 'origin':'http://localhost'},
     body: json.encode({
       "service_id": servideId,
       "template_id": templateId,
       "user_id": userId,

       "template_params":{
         "name": "o Usuario TESTE",
         "subject": "Titulo desd",
         "message": "OLA TESTE",
         "user_email": "crisneri39@gmail.com",
         "to_email": "crisneri39@gmail.com"
       }
     })
   );
   return response;
  }




}