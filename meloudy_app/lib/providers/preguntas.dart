import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meloudy_app/ips.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meloudy_app/providers/pregunta.dart';



class Preguntas with ChangeNotifier {
  List <Pregunta> preguntas = [];
  int indice = 0;
  final String authToken;

  Preguntas(this.authToken, this.preguntas);

  void setRespuestas(resp) {
    if(preguntas[indice].respuestas.contains(resp)) {
      if(preguntas[indice].tipo == 'multiple' || preguntas[indice].tipo == 'unica'){
        preguntas[indice].respuestas.remove(resp);
      }
    }
    else{
      preguntas[indice].respuestas.add(resp);
    }

    print("RESPUESTAS: " + preguntas[indice].respuestas.toString());
  }

  List<Pregunta> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...preguntas];
  }


  int get indiceValor {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return indice;
  }

  Future<void> fetchAndSetPreguntas(idLeccion) async {
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


      for (var i = 0; i < extractedData['pregunta'].length; i++) {

        final List<String> contenidoCargado = [];
        var contenidoLista = extractedData['pregunta'][i]['opciones'];
        for (var i = 0; i < contenidoLista.length; i++) {
          contenidoCargado.add(contenidoLista[i]);
        }
        preguntasCargadas.add(Pregunta(
            id: preguntasLista[i]['_id'],
            cuestion: preguntasLista[i]['cuestion'],
            tipo: preguntasLista[i]['tipo'],
            imagen: preguntasLista[i]['imagen'],
            opciones: contenidoCargado

        ));
        print("aasas");
        print(preguntasCargadas[i].opciones.toString());
      }

      preguntas = preguntasCargadas;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> siguientePregunta() async{
    indice++;
  }

  Future<void> preguntaAnterior() async{
    indice--;
  }

}
