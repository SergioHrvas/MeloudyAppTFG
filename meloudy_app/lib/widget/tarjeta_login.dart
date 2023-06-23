import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/lecciones.dart';
enum AuthMode { Signup, Login }

class TarjetaLogin extends StatefulWidget {
  const TarjetaLogin({
    Key key,
  }) : super(key: key);

  @override
  _TarjetaLoginState createState() => _TarjetaLoginState();
}

class _TarjetaLoginState extends State<TarjetaLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
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
      await Provider.of<Auth>(context, listen: false).registro(
          _authData['email'],
          _authData['password'],
          " ",
          ["ApellidoPrueba"," "],
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
                  key: Key('correo'),
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
                  key: Key('password'),

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
                    key: Key('boton1'),
                    child: Text(_authMode == AuthMode.Login
                        ? 'INICIAR SESIÓN'
                        : 'REGISTRARME',
                    ),
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
                            Theme.of(context).primaryTextTheme.labelLarge.color)),
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

}
