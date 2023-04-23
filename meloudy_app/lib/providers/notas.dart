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

  Opciones(this.opciones);

  var valor = false;


  int setValore(){
    valor = !valor;
    notifyListeners();
  }


  bool get val{
    return valor;
  }


  List<bool> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...opciones];
  }

  void anadirOpcion(){
    opciones.add(false);

    for(var i = 0; i < opciones.length; i++){
      print(opciones[i]);
    }
  }

  void borrarOpcion(i){
    opciones.removeAt(i);
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

  void limpiar(){
    opciones = [];
  }



  bool getOpcion(i){
    return opciones[i];
  }



}
