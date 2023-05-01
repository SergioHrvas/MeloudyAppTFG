import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:provider/provider.dart';

import '../image_controller.dart';
import '../ips.dart';
import '../providers/auth.dart';
import '../providers/notas.dart';
import '../providers/opciones.dart';
import '../providers/usuarios.dart';
import '../widget/drawer_app.dart';
import '../widget/subir_notas.dart';
import '../widget/subir_opcion.dart';

class PantallaCrearUsuarioProfesor extends StatefulWidget {
  static const routeName = '/crearusuario';

  @override
  _PantallaCrearUsuarioProfesorState createState() =>
      _PantallaCrearUsuarioProfesorState();
}

class _PantallaCrearUsuarioProfesorState
    extends State<PantallaCrearUsuarioProfesor> {
  _PantallaCrearUsuarioProfesorState();


  PickedFile _image;
  File file;

  var rol = 'Usuario';

  List<String> roles = ['Usuario', 'Admin', 'Profesor'];
  final ImagePicker picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _authData = {};


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }


  Future getImage(ImageSource media) async {
    var img = await picker.getImage(source: media);

    setState(() {

      file = File(img.path);
      _image = img;
    });
  }

  void submit() async {
    List<Map<String, String>> vectordatos = [];
    _formKey.currentState.save();

    _authData['rol'] = rol;
    var token = Provider.of<Auth>(context, listen: false).token;

    var opcs = Provider.of<Opciones>(context, listen: false).items;
    for(var j = 0; j < opcs.length; j++){
      print(opcs[j]);
    }

    await ImageController().upload(_image, token).then((_) {
      var img;
      if (_image == null) {
        print("aa");
        img = "musica.png";
      }
      else {
        img = file.uri.path
            .split('/')
            .last;
      }
      _authData['foto'] = img;

    });


    Provider.of<Usuarios>(context, listen: false)
        .crearUsuario(_authData)
        .then((value) => Navigator.pushReplacementNamed(
            context, '/listausuarios'));
  }


  @override
  Widget build(BuildContext context) {

    _authData['apellidos'] = [];
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  file!=null ? Container(
                    width:200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      image:  DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(file.path))
                      ),
                    ) ,
                  ) : Container(),
                  Container(
                    width: 200,

                    child: ElevatedButton(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload),
                            Text("SUBIR FOTO"),
                          ],
                        )),
                  ),
                  Container(
                    child: DropdownButton(
                        items: roles.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: rol,
                        onChanged: (String newvalue) {
                          setState(() {
                            rol = newvalue;
                          });
                        }),
                  ),
                  Container(
                margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                child: TextFormField(
                  onSaved: (value){
                    _authData['nombre'] = value;
                  },
                  decoration:
                      InputDecoration(labelText: "Nombre"),
                ),

              ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      onSaved: (value){
                        _authData['apellidos'].add(value);
                      },
                      decoration:
                      InputDecoration(labelText: "Primer apellido"),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      onSaved: (value){
                        _authData['apellidos'].add(value);
                      },
                      decoration:
                      InputDecoration(labelText: "Segundo apellido"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      onSaved: (value){
                        _authData['username'] = value;
                      },
                      decoration:
                      InputDecoration(labelText: "Nombre de usuario"),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      onSaved: (value){
                        _authData['correo'] = value;
                      },
                      decoration:
                      InputDecoration(labelText: "Correo electrónico"),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      obscureText: true,
                      onSaved: (value){
                        _authData['password'] = value;
                      },
                      decoration:
                      InputDecoration(labelText: "Contraseña"),
                    ),

                  ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    await submit();
                  },
                  child: Text(
                    "Crear Usuario",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
