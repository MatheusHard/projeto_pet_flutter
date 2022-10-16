import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:projeto_pet/ui/login.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      const MaterialApp(
        home: Login(),
        debugShowCheckedModeBanner: false,
      ));}

