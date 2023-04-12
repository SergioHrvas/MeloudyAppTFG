import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meloudy_app/ips.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meloudy_app/providers/pregunta.dart';
import 'package:provider/provider.dart';

import 'auth.dart';



class Partes with ChangeNotifier {
  int indice = 0;



  Partes();

  limpiarIndice(){
    indice = 0;
  }

  cambiarIndice(){

  }

  incrementar(){
    indice++;
  }

  decrementar(){
    indice--;
  }





}
