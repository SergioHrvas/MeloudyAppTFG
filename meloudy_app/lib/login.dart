import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meloudy_app/leccion.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:meloudy_app/providers/auth.dart';

enum AuthMode { Signup, Login }

class Login extends StatelessWidget {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("MELOUDY")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("sadasdadasd"),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                title: Text("Item 1"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Item 2"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(117, 234, 255, 1.0).withOpacity(0.5),
                  Color.fromRGBO(115, 100, 200, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0, top: 30.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 70.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue.shade500,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        "MELOUDY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(top: 5),
            ),
          ),
        ]));
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': 'ss', 'password': 'dsdsd'};
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    print(_authData);
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {

      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password']
      );
    } else {
      print("EMAIL: " + _authData['email']);
      print("PASSWORD: " + _authData['password']);

      await Provider.of<Auth>(context, listen: false).registro(
          _authData['email'],
          _authData['password'],
          "Nombreprueba",
          ["ApellidoPrueba","ddsda"],
          "Usuario");
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //obtenerLecciones();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return '¡Correo inválido!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return '¡Contraseña demasiado corta!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration:
                        InputDecoration(labelText: 'Confirmar contraseña'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return '¡Las contraseñas no coinciden!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child: Text(_authMode == AuthMode.Login
                        ? 'INICIAR SESIÓN'
                        : 'REGISTRARME'),
                    onPressed: _submit,
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryTextTheme.button.color)),
                  ),
                TextButton(
                  child: Text(
                      'QUIERO ${_authMode == AuthMode.Login ? 'REGISTRARME' : 'INICIAR SESIÓN'}'),
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 4)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void obtenerLecciones() {
    fetchLeccion().then((value) {
      print(value.body);
      print("=================");
      var a = jsonDecode(value.body);
      for(var i = 0; i < a['usuario'].length; i++) {
        print(i.toString() + "d " + a['usuario'][i]['nombre']);
      }
    });
  }

  Future<http.Response> fetchLeccion() {
    return http.get(Uri.parse('http://10.0.2.2:5000/api/user/get-users'));
  }
}
