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

class Notas with ChangeNotifier {
  List<String> notas = [];

  Notas(this.notas);

  List<String> get items {
    return [...notas];
  }

  void anadirNota() {
    notas.add("Do");
  }

  void borrarNota(i) {
    notas.removeAt(i);
    notifyListeners();
  }

  void setValor(indice, nota) {
    notas[indice] = nota;
  }

  void limpiar() {
    notas = [];
  }

  String getNota(i) {
    return notas[i];
  }

  Future<void> setNotas(respuestascorrectas) async {
    notas = respuestascorrectas;
  }
}
