import 'dart:io';
import 'package:meloudy_app/ips.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../modo.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String _rol;

  bool get isAuth {
    return token != null;
  }

  String get getRol {
    return _rol;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> registro(String email, String password, String nombre,
      List<String> apellidos, String rol) async {
    const url = 'http://${IP.ip}:5000/api/user/registro';
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
      _token = responseData['token'];
      _userId = responseData['usuario']['_id'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: responseData['expiresIn']));
      _autoLogout();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url = 'http://${IP.ip}:5000/api/user/login';
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
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['usuario']['_id'];
      _rol = responseData['usuario']['rol'];
      _expiryDate =
          DateTime.now().add(Duration(seconds: responseData['expiresIn']));
      if(MODO.modo == 0)
        _autoLogout();
      notifyListeners();
      if(MODO.modo == 0) {
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            'rol': _rol,
            'expireDate': _expiryDate.toIso8601String(),
          },
        );

        prefs.setString('userData', userData);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['expireDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _rol = extractedUserData['rol'];
    _expiryDate = expiryDate;

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
