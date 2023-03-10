import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meloudy_app/ips.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meloudy_app/providers/pregunta.dart';
import 'package:provider/provider.dart';

import 'auth.dart';



class Preguntas with ChangeNotifier {
  List <Pregunta> preguntas = [];
  int indice = 0;
  String idLeccion;
  final String authToken;
  String userId;
  String testId;
  String modo;

  Preguntas(this.authToken, this.preguntas);

  void setModo(nuevomodo){
    modo = nuevomodo;
    indice = 0;
  }
  void setRespuestas(resp) {
    if(preguntas[indice].respuestas.contains(resp)) {
      if(preguntas[indice].tipo == 'multiple'){
        preguntas[indice].respuestas.remove(resp);
      }
    }
    else{
      if(preguntas[indice].tipo == 'texto' || preguntas[indice].tipo == 'unica') {
        preguntas[indice].respuestas.removeRange(
            0, preguntas[indice].respuestas.length);
        preguntas[indice].respuestas.add(resp);
      }
      else if(preguntas[indice].tipo == 'multiple'){
        preguntas[indice].respuestas.add(resp);

      }
    }

    print("RESPUESTAS: " + preguntas[indice].respuestas.toString());
  }

  void setIdLeccion(id){
    idLeccion = id;
  }

  void setIdUser(id){
    userId = id;
  }

  List<Pregunta> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...preguntas];
  }

  String get idtest {
    print("SALGO");
    print(testId);
    return testId;
  }

  Future<void> setPulsado(num) async{
    preguntas[indice].pulsado[num] = !preguntas[indice].pulsado[num];
    if(preguntas[indice].tipo == 'unica' && preguntas[indice].pulsado[num] == true){
      for(var i = 0; i < preguntas[indice].pulsado.length; i++){
        if (i != num){
          preguntas[indice].pulsado[i] = false;
        }
      }
    }
    notifyListeners();
  }


  bool getPulsado(num){
    return preguntas[indice].pulsado[num];
  }


  int get indiceValor {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return indice;
  }

  int getAciertos(){
    var fallo;
    var contador = 0;
    for(var i = 0; i < preguntas.length; i++){
      fallo = false;
      for (var j = 0; j < preguntas[i].respuestas.length; j++){
        if(preguntas[i].respuestascorrectas.contains(preguntas[i].respuestas[j]) == false || preguntas[i].respuestascorrectas.length != preguntas[i].respuestas.length){
            fallo = true;
        }

      }
      if(!fallo){
        contador++;
      }
    }
    return contador;
  }

  Future<void> fetchAndSetPreguntas() async {
    print("TOKENE:" + authToken);

    final url = Uri.parse(
        'http://${IP.ip}:5000/api/question/get-questions?auth=$authToken');
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print("EXTRACTED DATA:");
      print(extractedData);

      if (extractedData == null) {
        return;
      }
      if (extractedData['auth'] == false) {
        return;
      }
      final List<Pregunta> preguntasCargadas = [];
      var preguntasLista = extractedData['pregunta'];

      print(extractedData['pregunta']);
      for (var i = 0; i < extractedData['pregunta'].length; i++) {

        final List<String> contenidoCargado = [];
        var contenidoLista = extractedData['pregunta'][i]['opciones'];
        List<bool> pulsadoLista = [];
        for (var j = 0; j < contenidoLista.length; j++) {
          contenidoCargado.add(contenidoLista[j]);
          pulsadoLista.add(false);
        }

        List<String> respuestasCorrectas = [];
        var contenidoListaRP = extractedData['pregunta'][i]['respuestascorrectas'];
        print("RC: " + extractedData['pregunta'][i]['respuestascorrectas'].toString());
        print(contenidoListaRP.length);
        for (var j = 0; j < contenidoListaRP.length; j++) {
          respuestasCorrectas.add(contenidoListaRP[j]);
        }

        print("RC2:" + respuestasCorrectas.toString());

        preguntasCargadas.add(Pregunta(
            id: preguntasLista[i]['_id'],
            cuestion: preguntasLista[i]['cuestion'],
            tipo: preguntasLista[i]['tipo'],
            imagen: preguntasLista[i]['imagen'],
            opciones: contenidoCargado,
            pulsado: pulsadoLista,
            respuestascorrectas: respuestasCorrectas
        ));
      }

      preguntas = preguntasCargadas;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> siguientePregunta() async{
    indice++;
    notifyListeners();

  }

  Future<void> preguntaAnterior() async{
    indice--;
    notifyListeners();
  }

  Future<void> enviarTest() async{
    final url = Uri.parse('http://${IP.ip}:5000/api/progress/create-test-and-progress');

    try{

      var preguntasTest = <Map<String, dynamic>>[];

      for(var i = 0; i < preguntas.length; i++){
        preguntasTest.add(<String, dynamic>{
          "idPregunta": preguntas[i].id,
          "respuestas": preguntas[i].respuestas,
        });
        print(preguntasTest.toString());
      }


      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode({
            'idLeccion': idLeccion,
            'preguntas': preguntasTest,
            'idUsuario': userId,

          }));
      final responseData = json.decode(response.body);
      print(responseData);
      testId = responseData['test'];
      print(testId);
      print("aaaaaa");
      return testId;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }


    } catch (error){
        throw(error);
    }
  }

}
