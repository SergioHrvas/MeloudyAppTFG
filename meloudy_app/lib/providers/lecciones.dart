import 'dart:convert';
import 'dart:io';
import 'package:meloudy_app/ips.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meloudy_app/providers/test.dart';
import '../modo.dart';
import './leccion.dart';

class Lecciones with ChangeNotifier {
  List<Leccion> lecciones = [];
  var aprobados = 0;
  String authToken;

  Lecciones();

  void update(tkn) {
    authToken = tkn;
  }

  List<Leccion> get items {
    return [...lecciones];
  }

  List<Test> getTests(id) {
    return findById(id).tests;
  }

  Leccion findById(String id) {
    return lecciones.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetLecciones(id) async {
    if ((id == "" || id == null) && MODO.modo == 1)
      id = '63fe53c56ac25d3aa7ac988b';
    final url = Uri.parse('http://${IP.ip}:5000/api/lesson/get-lessons/${id}');
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
      var ult = false;
      var leccionesLista = extractedData['leccion'];


      var listaListaTests = [];
      for (var i = 0; i < extractedData['leccion'].length; i++) {
        var pasado = false;
        var completadovar = null;
        var estado = 'bloqueado';

          for (var j = 0; j < extractedData['progreso'].length; j++) {
            if (extractedData['progreso'][j]['idLeccion'] ==
                extractedData['leccion'][i]['_id']) {
              var listaTests = [];

              for (var k = 0;
                  k < extractedData['progreso'][j]['tests'].length;
                  k++) {
                listaTests.add(extractedData['progreso'][j]['tests'][k]);
              }

              listaListaTests.add(listaTests);

              completadovar = extractedData['progreso'][j]['completado'];

              if (completadovar !=null ){
                if (completadovar) {
                  estado = 'completado';
                } else {
                    estado = 'bloqueado';
                }
              }
              pasado = true;
            }
        }

        if(!pasado){
          if(!ult){
            estado = 'desbloqueado';
            ult = true;
          }
          listaListaTests.add([]);
        }

        final List<Contenido> contenidoCargado = [];
        var contenidoLista = extractedData['leccion'][i]['contenido'];
        if (contenidoLista != null) {
          for (var i = 0; i < contenidoLista.length; i++) {
            contenidoCargado.add(Contenido(
                texto: contenidoLista[i]['texto'],
                tipo: contenidoLista[i]['tipo']));
          }
        }

        var n = buscarNumAprobados(
            extractedData['tests'], leccionesLista[i]['_id']);

        var numAprobados = 0;
        if (n != -1)
          numAprobados = extractedData['tests'][n]['testsAprobados'];
        else
          numAprobados = -1;

        leccionesCargadas.add(Leccion(
            id: leccionesLista[i]['_id'],
            nombre: leccionesLista[i]['nombre'],
            contenido: contenidoCargado,
            imagenprincipal: leccionesLista[i]['imagenprincipal'],
            estado: estado,
            tests: listaListaTests[i],
            num_aprobados: numAprobados));
      }

      lecciones = leccionesCargadas;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  int getIndice(id) {
    for (var i = 0; i < lecciones.length; i++) {
      if (lecciones[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  Future<void> modificarLeccion(data, id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/lesson/update-lesson/${id}?auth=$authToken');

    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "nombre": data['nombre'],
          "imagenprincipal": data['imagenprincipal'],
          "contenido": data['contenido']
        }));

    var extractedData = json.decode(response.body);

    final List<Contenido> contenidovector = [];
    if (extractedData['leccion'] != null) {
      if (extractedData['leccion']['contenido'] != null) {
        for (var i = 0; i < extractedData['leccion']['contenido'].length; i++) {
          contenidovector.add(Contenido(
              tipo: extractedData['leccion']['contenido'][i]['tipo'].toString(),
              texto: extractedData['leccion']['contenido'][i]['texto']
                  .toString()));
        }
      }

      var i = getIndice(id);

      lecciones[i] = Leccion(
          id: extractedData['leccion']['_id'],
          nombre: extractedData['leccion']['nombre'],
          imagenprincipal: extractedData['leccion']['imagenprincipal'],
          contenido: contenidovector);
    }
  }

  Future<void> crearLeccion(data) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/lesson/create-lesson?auth=$authToken');

    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "nombre": data['nombre'],
          "imagenprincipal": data['imagenprincipal'],
          "contenido": data['contenido']
        }));

    var extractedData = json.decode(response.body);

    final List<Contenido> contenidovector = [];
    if (extractedData['leccion'] != null) {
      if (extractedData['leccion']['contenido'] != null) {
        for (var i = 0; i < extractedData['leccion']['contenido'].length; i++) {
          contenidovector.add(Contenido(
              tipo: extractedData['leccion']['contenido'][i]['tipo'].toString(),
              texto: extractedData['leccion']['contenido'][i]['texto']
                  .toString()));
        }
      }

      lecciones.add(Leccion(
          id: extractedData['leccion']['_id'],
          nombre: extractedData['leccion']['nombre'],
          imagenprincipal: extractedData['leccion']['imagenprincipal'],
          contenido: contenidovector));
    }
  }

  int buscarNumAprobados(data, id) {
    for (var i = 0; i < data.length; i++) {
      if (data[i]['idLeccion'] == id) {
        return i;
      }
    }
    return -1;
  }

  Future<void> fetchAndSetTests(idLeccion, idUsuario) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/test/get-tests-progress/${idUsuario}/${idLeccion}?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<Test> testsCargados = [];

      for (var i = 0; i < extractedData['tests'].length; i++) {
        testsCargados.add(Test(
          id: extractedData['tests'][i]['_id'],
          fecha_creacion: extractedData['tests'][i]['fecha_creacion'],
          aciertos: extractedData['tests'][i]['num_aciertos'],
        ));
      }

      findById(idLeccion).setTests(testsCargados);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> borrarLeccion(String id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/lesson/delete-lesson/$id?auth=$authToken');
    final leccionExistenteIndice =
        lecciones.indexWhere((leccion) => leccion.id == id);
    var leccionExistente = lecciones[leccionExistenteIndice];
    lecciones.removeAt(leccionExistenteIndice);
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      lecciones.insert(leccionExistenteIndice, leccionExistente);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    notifyListeners();

    leccionExistente = null;
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
*/
}
