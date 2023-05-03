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
  List <Logro> logros = [];

  String authToken;


  Logros(this.authToken, this.logros);

  void update(tkn){
    authToken = tkn;
  }

  List<Logro> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...logros];
  }



  Future<void> fetchAndSetLogros() async {
    final url = Uri.parse(
        'http://${IP.ip}:5000/api/achievement/get-achievement/?auth=$authToken');
    try {
      logros = [];

      final response = await http.get(url);
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      for(var i = 0; i < extractedData['logros'].length; i++) {
        logros.add(
            Logro(id: extractedData['logros'][i]['_id'],
                nombre: extractedData['logros'][i]['nombre'],
                imagen: extractedData['logros'][i]['imagen'],
                descripcion: extractedData['logros'][i]['descripcion'],
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

  Logro findById(String id) {
    return logros.firstWhere((prod) => prod.id == id);
  }



}
