import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meloudy_app/ips.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meloudy_app/providers/usuario.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'logro.dart';

class Logros with ChangeNotifier {
  List<Logro> logros = [];

  String authToken;

  Logros();

  void update(tkn) {
    authToken = tkn;
  }

  List<Logro> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...logros];
  }

  int getIndice(id) {
    for (var i = 0; i < logros.length; i++) {
      if (logros[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  Future<void> fetchAndSetLogros() async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/achievement/get-achievement/?auth=$authToken');
    try {
      logros = [];

      final response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      for (var i = 0; i < extractedData['logros'].length; i++) {
        logros.add(Logro(
            id: extractedData['logros'][i]['_id'],
            nombre: extractedData['logros'][i]['nombre'],
            imagen: extractedData['logros'][i]['imagen'],
            descripcion: extractedData['logros'][i]['descripcion'],
            tipo: extractedData['logros'][i]['tipo'],
            condicion: extractedData['logros'][i]['condicion']));
      }

      if (extractedData == null) {
        return;
      }
      if (extractedData['auth'] == false) {
        return;
      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  crearLogro(extractedData) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/achievement/create-achievement?auth=$authToken');

    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "nombre": extractedData['nombre'],
          "descripcion": extractedData['descripcion'],
          "imagen": extractedData['imagen'],
          "tipo":extractedData['tipo'],
          "condicion":extractedData['condicion']
        }));

    var respuesta = jsonDecode(response.body);
    if (respuesta['status'] == "success") {
      logros.add(Logro(
          id: respuesta['logro']['_id'],
          nombre: extractedData['nombre'],
          descripcion: extractedData['descripcion'],
          imagen: extractedData['imagen'],
          tipo: extractedData['tipo'],
          condicion: extractedData['condicion']
      ));

      notifyListeners();
    }
  }

  editarLogro(extractedData, id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/achievement/update-achievement/${id}?auth=$authToken');

    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "nombre": extractedData['nombre'],
          "descripcion": extractedData['descripcion'],
          "imagen": extractedData['imagen'],
          "tipo":extractedData['tipo'],
          "condicion":extractedData['condicion']
        }));

    var respuesta = jsonDecode(response.body);
    if (respuesta['status'] == "success") {
      var logro = findById(id);
      logro.nombre = extractedData['nombre'];
      logro.descripcion = extractedData['descripcion'];
      logro.imagen = extractedData['imagen'];
      logro.tipo = extractedData['tipo'];
      logro.condicion = extractedData['condicion'];
      notifyListeners();
    }
  }



  borrarLogro(String id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/achievement/delete-achievement/${id}?auth=$authToken');

    var i = getIndice(id);
    logros.removeAt(i);

    final response = await http.delete(url);
    notifyListeners();
  }

  Logro findById(String id) {
    return logros.firstWhere((prod) => prod.id == id);
  }

  Future<Logro> getLogro(String id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/achievement/get-achievement/${id}?auth=$authToken');

    final response = await http.get(url);
    var respuesta = jsonDecode(response.body);

    return Logro(
        id: respuesta['logro']['_id'],
        imagen: respuesta['logro']['imagen'],
        nombre: respuesta['logro']['nombre'],
        descripcion: respuesta['logro']['descripcion'],
        tipo: respuesta['logro']['tipo']

    );
  }
}
