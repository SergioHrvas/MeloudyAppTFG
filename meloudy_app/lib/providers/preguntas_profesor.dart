import 'dart:ffi';
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



class PreguntasProfesor with ChangeNotifier {
  List <Pregunta> preguntas = [];
  int indice = 0;

  final String authToken;

  String idLeccion;
  String userId;
  String testId;

  PreguntasProfesor(this.authToken, this.preguntas);

  List<Pregunta> get items {
    return [...preguntas];
  }

  String get idtest {

    return testId;
  }

  String getRespuesta(){
    var resp = "";
    if(preguntas[indice].respuestas.length > 0){
      resp = preguntas[indice].respuestas[0];
    }
    return resp;
  }


  int get indiceValor {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return indice;
  }


  void cambiarPreguntas(extractedData){
    final List<Pregunta> preguntasCargadas = [];
    var preguntasLista = extractedData['preguntas'];

    for (var i = 0; i < extractedData['preguntas'].length; i++) {

      final List<String> contenidoCargado = [];
      var contenidoLista = extractedData['preguntas'][i]['opciones'];
      List<bool> pulsadoLista = [];
      for (var j = 0; j < contenidoLista.length; j++) {
        contenidoCargado.add(contenidoLista[j]);
        pulsadoLista.add(false);
      }

      List<String> respuestasCorrectas = [];
      var contenidoListaRP = extractedData['preguntas'][i]['respuestascorrectas'];

      for (var j = 0; j < contenidoListaRP.length; j++) {
        respuestasCorrectas.add(contenidoListaRP[j]);
      }

      preguntasCargadas.add(Pregunta(
          id: preguntasLista[i]['_id'],
          cuestion: preguntasLista[i]['cuestion'],
          tipo: preguntasLista[i]['tipo'],
          imagen: preguntasLista[i]['imagen'],
          opciones: contenidoCargado,
          pulsado: pulsadoLista,
          respuestascorrectas: respuestasCorrectas,
          leccion: preguntasLista[i]['leccion']
      ));
    }

    preguntas = preguntasCargadas;

  }

  Map<String, List<dynamic>> getOpciones(id){
    var pregunta = findById(id);

    List<dynamic> respuestascorrectas = [];
    if(pregunta.tipo == 'multiple' || pregunta.tipo == 'unica') {

    for(var i = 0; i < pregunta.opciones.length; i++){
        respuestascorrectas.add(false);

    }
      for (var i = 0; i < pregunta.respuestascorrectas.length; i++) {
        respuestascorrectas[int.parse(pregunta.respuestascorrectas[i])] = true;
      }
    }
    else if(pregunta.tipo == 'texto' || pregunta.tipo == 'microfono'){
        respuestascorrectas = pregunta.respuestascorrectas;
    }

    return {"opciones" : pregunta.opciones,
      "respuestascorrectas": respuestascorrectas};
  }


  Future<void> fetchAndSetPreguntas() async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/question/get-questions?auth=$authToken');
    try {
      final response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      print(extractedData.toString());

      if (extractedData == null) {
        return;
      }
      if (extractedData['auth'] == false) {
        return;
      }

      preguntas = [];
      var n = extractedData['preguntas'].length;


      cambiarPreguntas(extractedData);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Pregunta findById(String id) {
    return preguntas.firstWhere((prod) => prod.id == id);
  }





}
