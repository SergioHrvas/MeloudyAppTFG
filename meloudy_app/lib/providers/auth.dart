import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null){
      return _token;
    }
    return null;
  }
  Future<void> registro(String email, String password, String nombre,
      List<String> apellidos, String rol) async {
    const url = 'http://10.0.2.2:5000/api/user/create-user';
    print("Email" + email);
    print("Password" + password);
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode({
            "correo": email,
            "password": password,
            "nombre": "asassa",
            "apellidos": ["as", "afdafd"],
            "rol": "Admin"
          }));
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      print(responseData);
      _token = responseData['token'];
      _userId = responseData['usuario']['_id'];
      _expiryDate = DateTime.now().add(
          Duration(seconds: responseData['expiresIn']));
      notifyListeners();
    }
    catch (error){
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url = 'http://10.0.2.2:5000/api/user/login';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode({
            "correo": email,
            "password": password,
          }));
      final responseData = json.decode(response.body);
      print("R");
      print(responseData);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['usuario']['_id'];
      _expiryDate = DateTime.now().add(
          Duration(seconds: responseData['expiresIn']));
      notifyListeners();
    }
    catch (error){
      throw error;
    }
    }
  }


