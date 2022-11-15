
  import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as crypt;


  class Utils {


  static String URL_WEB_SERVICE = "http://192.168.0.11:8080/api/";
  //String URL_WEB_SERVICE = "http://avaliacoes-backend.herokuapp.com/";
  static const String IMG_KEY = 'IMAGE_KEY';



  static  final key = crypt.Key.fromUtf8('put32charactershereeeeeeeeeeeee!'); //32 chars
  static final iv = crypt.IV.fromUtf8('put16characters!'); //16 chars

//encrypt
    static String encryptAES(String text) {
      final e = crypt.Encrypter(crypt.AES(key, mode: crypt.AESMode.cbc));
      final encrypted_data = e.encrypt(text, iv: iv);
      return encrypted_data.base64;
    }

//dycrypt
    static String decryptAES(String text) {
      final e = crypt.Encrypter(crypt.AES(key, mode: crypt.AESMode.cbc));
      final decrypted_data = e.decrypt(crypt.Encrypted.fromBase64(text), iv: iv);
      return decrypted_data;
    }









  /***************DataHora***************/

  static DateTime getDataHora(){
  return DateTime.now();
  }
  static String formatarData(String data, bool small){
    var formater;

    initializeDateFormatting("pt_BR");
    if(small){
      formater = DateFormat("dd/MM/y");
    }else{
      formater = DateFormat("dd/MM/y H:m");
    }
    DateTime dataConvertida =  DateTime.parse(data);
    String date = formater.format(dataConvertida);

    return date;
  }
  /**************Mostrar Texto**************/
  static void showDefaultSnackbar(BuildContext context, String texto) {
  //Scaffold.of(context).showSnackBar(
    final snackBar = SnackBar(
      content: Text((texto.isEmpty) ? "" : texto.toString()),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
  );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  static String showDose(String value){

      String dose = "";

      switch(value) {
        case 'D1':
        dose =  '1ª Dose';
        break;
        case 'D2':
         dose =  '2ª Dose';
        break;
        case 'D3':
         dose =  '3ª Dose';
        break;
        case 'D4':
          dose =  '4ª Dose';
        break;
        case 'REF':
          dose =  'Reforço';
        break;
        case 'UNI':
          dose =  'Única';
        break;

      }
      return dose;
  }

  static Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(IMG_KEY, value);
  }

  static Future<String?> getImagesFromPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(IMG_KEY);
  }

  static String base64String(Uint8List bytes){
    return base64Encode(bytes);
  }

  static String formatarDateTime(DateTime? data){
      if(data != null ){
        if(data.month < 10 && data.day < 10){
          return '0${data.day}/0${data.month}/${data.year}';
        }else if(data.day >= 10 && data.month < 10){
          return '${data.day}/0${data.month}/${data.year}';
        }else if(data.day < 10 && data.month >= 10){
          return '0${data.day}/${data.month}/${data.year}';
        }else{
          return '${data.day}/${data.month}/${data.year}';
        }
      }
      return data.toString();

  }

  static Image imageFromBase64String(String bytes){
    return Image.memory(

        base64Decode(bytes),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.fill,
        alignment: Alignment.center,

        );
  }
  }














































