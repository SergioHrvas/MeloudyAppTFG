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

class Opciones with ChangeNotifier {
  List<bool> opciones = [];
  List<String> opcionesTexto = [];

  Opciones(this.opciones);

  List<bool> get items {
    return [...opciones];
  }

  List<String> get itemsTexto {
    return [...opcionesTexto];
  }

  void anadirOpcion(){
    opciones.add(false);
    opcionesTexto.add("");
  }


  void borrarOpcion(i){
    opciones.removeAt(i);
    opcionesTexto.removeAt(i);
  }

  void setValor(indice, tipo){
    if(tipo == 'unica' && opciones[indice]==false){
      for(var i = 0; i < opciones.length; i++){
        opciones[i] = false;
      }
    }
    opciones[indice] = !opciones[indice];
    notifyListeners();
  }

  void setValorTexto(indice, valor){
    opcionesTexto[indice] = valor;
  }

  void limpiar(){
    opciones = [];
    opcionesTexto = [];
  }



  bool getOpcion(i){
    return opciones[i];
  }

  String getOpcionTexto(i){
    return opcionesTexto[i];
  }



}
