import 'dart:convert';

//import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:sendgrid_mailer/sendgrid_mailer.dart';



class SendEmail {
  String? _username;
  var smtpServer;

  SendEmail(String username, String password){
    _username = username;
    //smtpServer = gmail(_username!, password);
  }

  void sendTwilioEmail() {
try{
    final mailer = Mailer(
        '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');
    const toAddress = Address('crisneri39@gmail.com');
    const fromAddress = Address('matheushard2013@gmail.com');
    const content = Content('text/plain', 'Hello World!');
    const subject = 'Hello Subject!';
    const personalization = Personalization([toAddress]);

    const email = Email([personalization], fromAddress, subject, content: [content]);

    mailer.send(email).then((result) {
      // ...
      print("RESULT");

      print( result);
    }).catchError((Error onError){
      print('OnError');
      print(onError);
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