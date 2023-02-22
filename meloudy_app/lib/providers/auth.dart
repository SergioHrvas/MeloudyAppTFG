import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> registro(String email, String password, String nombre,
      List<String> apellidos, String rol) async {
    const url = 'http://10.0.2.2:5000/api/user/create-user';
    print("Email2" + email);
    print("Password2" + password);
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
    print(json.decode(response.body));

  }

  Future<void> login(String email, String password) async {
    const url = 'http://10.0.2.2:5000/api/user/login';
    final response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode({
          "correo": email,
          "password": password,
        }));
    print(json.decode(response.body));

  }

}
