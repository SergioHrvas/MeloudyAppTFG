import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> registro(String email, String password) async{
    const url = 'http://localhost:8000/create-user';
    final response = await http.post(Uri.parse(url), body: json.encode(
        {
      email: email,
      password: password
    })
    );

    print(json.decode(response.body));
  }
}
