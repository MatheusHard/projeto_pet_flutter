import 'dart:convert';
import 'dart:math';

//import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:sendgrid_mailer/sendgrid_mailer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/dono.dart';




class SendEmail {
  String? _username;
  var smtpServer;
  Dono? _dono;

  SendEmail(Dono? dono){
    _dono = dono;
    }

  void sendTwilioEmail() {

  try{

    var codigo = (_dono?.codigoRecuperacao != null) ? _dono?.codigoRecuperacao: "";
    var key = dotenv.env['API_KEY_TWILIO'];

      var mailer = Mailer(
          key!);
      var toAddress = Address('crisneri39@gmail.com');
      var fromAddress = Address('matheushard2013@gmail.com');
      var content = Content('text/plain', '''Codigo de Verificação -> ${codigo}''');
      var subject = 'Codigo de Autenticação!';
      var personalization = Personalization([toAddress]);

      var email = Email([personalization], fromAddress, subject, content: [content]);

      mailer.send(email).then((result) {
        ///Exibir erro:
        if(result.isError) print( result.asError?.error.toString());

        if(result.isValue) {
          ///Ir pra tela do código:
        }

        ///Página para inserir codigo:


      }).catchError((Error onError){
        print('''OnErro: ${onError.stackTrace}''');
      });

    }catch(error){
  print("ERRO");
  print(error);

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