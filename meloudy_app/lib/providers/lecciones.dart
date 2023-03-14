import 'dart:convert';
import 'package:meloudy_app/ips.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meloudy_app/providers/test.dart';
import './leccion.dart';

class Lecciones with ChangeNotifier {
  List<Leccion> lecciones = []; // var _showFavoritesOnly = false;

  final String authToken;

  Lecciones(this.authToken, this.lecciones);
  List<Leccion> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...lecciones];
  }

  List<Test> getTests(id){
    return findById(id).tests;
  }

  Leccion findById(String id) {
    return lecciones.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetLecciones(id) async {

    final url = Uri.parse(
        'http://${IP.ip}:5000/api/lesson/get-lessons/${id}?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      if (extractedData['auth'] == false) {
        return;
      }

      final List<Leccion> leccionesCargadas = [];
      var ultimo = false;
      var leccionesLista = extractedData['leccion'];
      for (var i = 0; i < extractedData['leccion'].length; i++) {
        var completadovar = null;
        var estado = 'bloqueado';
        print(extractedData['progreso'].length);
        for(var j = 0; j < extractedData['progreso'].length; j++){

          if(extractedData['progreso'][j]['idLeccion']==extractedData['leccion'][i]['_id']) {
            completadovar = extractedData['progreso'][j]['completado'];
            print(i.toString() + completadovar.toString());
            if (completadovar == null){
              if(ultimo == false){
                estado = 'desbloqueado';
                ultimo = true;
              }
              else{
                estado = 'bloqueado';
              }
          }
            else {
              estado = 'completado';
            }
          }
          else{
            if(ultimo == false){
              estado = 'desbloqueado';
              ultimo = true;
            }
            else{
              estado = 'bloqueado';
            }
          }
        }
        print("Estado;" + estado);
        final List<Contenido> contenidoCargado = [];
        var contenidoLista = extractedData['leccion'][i]['contenido'];
        for (var i = 0; i < contenidoLista.length; i++) {
          contenidoCargado.add(Contenido(
              texto: contenidoLista[i]['texto'],
              tipo: contenidoLista[i]['tipo']));
        }
        leccionesCargadas.add(Leccion(
            id: leccionesLista[i]['_id'],
            nombre: leccionesLista[i]['nombre'],
            contenido: contenidoCargado,
            imagenprincipal: leccionesLista[i]['imagenprincipal'],
            estado: estado));

      }
      lecciones = leccionesCargadas;
      print(lecciones[0].estado);


      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetTests(idLeccion, idUsuario) async{
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/test/get-tests-progress/${idUsuario}/${idLeccion}');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print("eeeddd: " + extractedData.toString());

      final List<Test> testsCargados = [];

      print(extractedData['tests'].length);
      for(var i = 0; i < extractedData['tests'].length; i++){
        testsCargados.add(Test(
            id: extractedData['tests'][i]['_id'],
            fecha_creacion: extractedData['tests'][i]['fecha_creacion'],
            aciertos: extractedData['tests'][i]['aciertos'],
        ));
      }

      findById(idLeccion).setTests(testsCargados);


    }
    catch (error){
      throw(error);
    }

  }



  /* Future<void> addProduct(Leccion leccion) async {
    final url = Uri.parse('https://flutter-update.firebaseio.com/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'nombre': leccion.nombre,
          'texto': leccion.texto,
        }),
      );
      final newProduct = Leccion(
        nombre: leccion.nombre,
        texto: leccion.texto,
        id: json.decode(response.body)['_id'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Leccion newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-update.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-update.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }*/
}
