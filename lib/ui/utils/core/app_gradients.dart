import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {

  static const boxPetGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.black38
      ]);

  static const petFemea =  LinearGradient(
      begin: Alignment.topCenter,
      end: AlignmentDirectional.bottomEnd,
      colors: [
        Color(0xffffafbd),
        Color(0xffffc3a0)
      ]);

  static const LinearGradient petMacho = LinearGradient(
      begin: Alignment.topCenter,
      end: AlignmentDirectional.bottomEnd,
      colors: [

        Color(0xff2193b0),
        Color(0xff6dd5ed)
      ]);
  static const linear = LinearGradient(colors: [
    Color(0xFF57B6E5),
    Color.fromRGBO(130, 87, 229, 0.695),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

static const sol =
  LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: <Color>[
  Color(0xff1f005c),
  Color(0xff5b0060),
  Color(0xff870160),
  Color(0xffac255e),
  Color(0xffca485c),
  Color(0xffe16b5c),
  Color(0xfff39060),
  Color(0xffffb56b),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
  );



}
