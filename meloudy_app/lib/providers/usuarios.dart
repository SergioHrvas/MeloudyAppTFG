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



class Usuarios with ChangeNotifier {
  List <Usuario> usuarios = [];

  String authToken;


  Usuarios(this.authToken, this.usuarios);

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
                username: extractedData['usuario'][i]['username']

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




}
