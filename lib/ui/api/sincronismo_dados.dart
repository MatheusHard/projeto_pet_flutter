import 'dart:convert';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;

class SincronismoDados{

 static final url_paises = Uri.parse("https://servicodados.ibge.gov.br/api/v1/paises/");

  static getPaises() async {
    http.Response res;

    res = await http.get(url_paises);

    print(res.statusCode.toString());
    print(res.contentLength);
    print(res.body);


  List  dados = json.decode(res.body);
  for (int i = 0; i < dados.length; i++) {
        print('''Nome Pais: ${dados[i]["nome"]["abreviado"]}''');
    }

  }





}