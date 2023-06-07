
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meloudy_app/ips.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meloudy_app/providers/usuario.dart';
import 'package:provider/provider.dart';

import 'auth.dart';



class Usuarios with ChangeNotifier {
  List <Usuario> usuarios = [];

  String authToken;


  Usuarios();

  void update(tkn){
    authToken = tkn;
  }

  List<Usuario> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...usuarios];
  }



  Future<void> fetchAndSetUsers() async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/user/get-users/?auth=$authToken');
    try {
      usuarios = [];
      final response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;

      for(var i = 0; i < extractedData['usuario'].length; i++) {
        var apellidos = extractedData['usuario'][i]['apellidos'];
        List<String> apellidosmap = [];

        for(var j = 0; j < apellidos.length; j++){
          apellidosmap.add(apellidos[j]);
        }

        usuarios.add(
            Usuario(id: extractedData['usuario'][i]['_id'],
                nombre: extractedData['usuario'][i]['nombre'],
                foto: extractedData['usuario'][i]['foto'],
                apellidos: apellidosmap,
                correo: extractedData['usuario'][i]['correo'],
                username: extractedData['usuario'][i]['username'],
                rol: extractedData['usuario'][i]['rol']

            )
        );
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

  borrarUsuario(String id, int i) async{
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/user/delete-user/${id}?auth=$authToken');

    usuarios.removeAt(i);
    final response = await http.delete(url);
    notifyListeners();
  }

  crearUsuario(extractedData) async{
    print(extractedData.toString());

    final url = Uri.parse(
        'http://${IP.ip}:5000/api/user/registro?auth=$authToken');

    var apellidos = extractedData['apellidos'];
    List<String> apellidosmap = [];

    for(var j = 0; j < apellidos.length; j++){
      apellidosmap.add(apellidos[j]);
    }

    final response = await http.post(url,           headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
        body: json.encode({
          "correo": extractedData['correo'],
          "password": extractedData['password'],
          "nombre": extractedData['nombre'],
          "apellidos": apellidosmap,
          "rol": extractedData['rol'],
          "username": extractedData['username'],

        }));
    print(response.body);
  var respuesta = jsonDecode(response.body);
  if(respuesta['status'] == "success"){
    usuarios.add(
        Usuario(id: respuesta['usuario']['_id'], nombre: extractedData['nombre'], apellidos: apellidosmap, correo: extractedData['correo'], username: extractedData['username'], foto: extractedData['foto'])
    );
    notifyListeners();
  }
  }


  actualizarUsuario(Map<String, dynamic> extractedData, id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/user/update-user/${id}?auth=$authToken');

    var apellidos = extractedData['apellidos'];
    List<String> apellidosmap = [];

    for(var j = 0; j < apellidos.length; j++){
      apellidosmap.add(apellidos[j]);
    }

    Map<String, dynamic> cuerpo = {
      "foto": extractedData['foto'],
      "correo": extractedData['correo'],
      "nombre": extractedData['nombre'],
      "apellidos": apellidosmap,
      "username": extractedData['username'],
      "rol": extractedData['rol']
    };
    if(extractedData['password'] != ""){
      cuerpo["password"] = extractedData['password'];
    }

    var body = json.encode(cuerpo);


    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);

    var user = findById(id);
    user.nombre = extractedData["nombre"];

    print(usuarios[2].nombre);
    notifyListeners();

  }


  Usuario findById(String id) {
    return usuarios.firstWhere((prod) => prod.id == id);
  }



}
