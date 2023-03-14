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
  int aciertos = 0;

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

  int getAciertos(){
    return aciertos;
  }

  int calcularAciertos(){
    aciertos = 0;
    var fallo;
    for(var i = 0; i < preguntas.length; i++){
      fallo = false;
      if(preguntas[i].respuestas.length <= 0){
        fallo = true;
      }
      for (var j = 0; j < preguntas[i].respuestas.length && !fallo; j++){
        print(preguntas[i].respuestascorrectas.contains(preguntas[i].respuestas[j].toString()));
        if(preguntas[i].respuestascorrectas.contains(preguntas[i].respuestas[j]) == false || (preguntas[i].tipo == 'multiple' && preguntas[i].respuestascorrectas.length != preguntas[i].respuestas.length)){
            fallo = true;
        }

      }
      if(!fallo){
        aciertos++;
       print("------------VERIFICADOR------------");
        print("pregunta" + i.toString());
        print("respuestas: " + preguntas[i].respuestas.toString());

        print("respuestascorrectas: " + preguntas[i].respuestascorrectas.toString());
        print("CONTADOR:" + aciertos.toString());
      }
    }

  }

  Future<void> fetchAndSetPreguntas(leccion) async {
    print("TOKENE:" + authToken);
    print(leccion);
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/question/get-questions/${leccion}?auth=$authToken');
    try {
      final response = await http.get(url);

      var extractedData = json.decode(response.body) as Map<String, dynamic>;

      extractedData['preguntas'].shuffle();

      if (extractedData == null) {
        return;
      }
      if (extractedData['auth'] == false) {
        return;
      }


      var num_preguntas = 10;

      cambiarPreguntas(num_preguntas, extractedData);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }


  Future<void> setPreguntas(test) async {
    print(test);
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/question/get-questions-test/${test}?auth=$authToken');
    try {
      final response = await http.get(url);

      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      if (extractedData['auth'] == false) {
        return;
      }


      var num_preguntas = extractedData['preguntas'].length;

      cambiarPreguntas(num_preguntas, extractedData);

      //Cambiamos las respuestas

      print(preguntas[0]);

      print(extractedData['test']);
      for(var i = 0; i < extractedData['test']['preguntas'].length; i++){
        for(var j = 0; j < extractedData['test']['preguntas'][i]['respuestas'].length; j++) {
          preguntas[i].respuestas.add(extractedData['test']['preguntas'][i]['respuestas'][j]);
        }
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void cambiarPreguntas(num_preguntas, extractedData){
    final List<Pregunta> preguntasCargadas = [];
    var preguntasLista = extractedData['preguntas'];

    for (var i = 0; i < num_preguntas; i++) {

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
          respuestascorrectas: respuestasCorrectas
      ));
    }
    preguntas = preguntasCargadas;

  }

  void vaciarPreguntas(){
    preguntas = [];
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
      aciertos = getAciertos();
      var aprobado = false;
      if(aciertos>=5){
        aprobado = true;
      }

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
            "aprobado": aprobado
          }));

      final responseData = json.decode(response.body);
      print(responseData);
      testId = responseData['test'];

      return testId;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }


    } catch (error){
        throw(error);
    }
  }



}
