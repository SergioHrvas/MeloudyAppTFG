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



class UsuarioPerfil with ChangeNotifier {
  Usuario user;

  String authToken;


  UsuarioPerfil(this.authToken, this.user);

  void update(tkn){
    authToken = tkn;
  }

 Usuario get item {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return user;
  }



  Future<void> fetchAndSetUser(id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/user/get-user/${id}?auth=$authToken');
    try {
      final response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;

      for(var i = 0; i < extractedData['usuario'].length; i++) {
        var apellidos = extractedData['usuario']['apellidos'];
        List<String> apellidosmap = [];

        for(var j = 0; j < apellidos.length; j++){
          apellidosmap.add(apellidos[j]);
        }

        var logros = extractedData['logros'];
        List<Logro> logrosmap = [];

        for(var j = 0; j < logros.length; j++){
          logrosmap.add(Logro(
            id: logros[j]['_id'],
           nombre: logros[j]['nombre'],
           descripcion: logros[j]['descripcion'],
           imagen: logros[j]['imagen'],
              tipo: logros[j]['tipo']

          ));
        }

        user = Usuario(id: extractedData['usuario']['_id'],
                nombre: extractedData['usuario']['nombre'],
                foto: extractedData['usuario']['foto'],
                apellidos: apellidosmap,
                correo: extractedData['usuario']['correo'],
                username: extractedData['usuario']['username'],
                rol: extractedData['usuario']['rol'],
                logros: logrosmap

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

  actualizarUsuario(Map<String, dynamic> extractedData, id) async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/user/update-user/${id}?auth=$authToken');

    try{


    var apellidos = extractedData['apellidos'];
    List<String> apellidosmap = [];

    for(var j = 0; j < apellidos.length; j++){
      apellidosmap.add(apellidos[j]);
    }

    Map<String, dynamic> cuerpo = {
      "foto": extractedData['foto'],
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

    user.foto = extractedData["foto"];
    user.nombre = extractedData["nombre"];
    user.apellidos = [];
    user.apellidos.add(extractedData["apellidos"][0]);

    user.apellidos.add(extractedData["apellidos"][1]);
    user.rol = extractedData["rol"];
    user.username = extractedData["username"];
    notifyListeners();
    }
    catch(error){
      throw(error);
}
  }



}
