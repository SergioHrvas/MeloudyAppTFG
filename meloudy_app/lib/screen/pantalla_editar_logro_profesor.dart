import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:provider/provider.dart';

import '../image_controller.dart';
import '../ips.dart';
import '../providers/auth.dart';
import '../providers/logros.dart';
import '../providers/notas.dart';
import '../providers/opciones.dart';
import '../providers/usuarios.dart';
import '../widget/drawer_app.dart';
import '../widget/subir_notas.dart';
import '../widget/subir_opcion.dart';

class PantallaEditarLogroProfesor extends StatefulWidget {
  static const routeName = '/editarlogro';

  @override
  _PantallaEditarLogroProfesorState createState() =>
      _PantallaEditarLogroProfesorState();
}

class _PantallaEditarLogroProfesorState
    extends State<PantallaEditarLogroProfesor> {
  _PantallaEditarLogroProfesorState();


  PickedFile _image;
  File file;

  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _authData = {};

  var id;
  var logro;

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
    _formKey.currentState.save();

    var token = Provider.of<Auth>(context, listen: false).token;

    await ImageController().upload(_image, token).then((_) {
      var img;
      if (_image == null) {
        img = logro.imagen;
      }
      else {
        img = file.uri.path
            .split('/')
            .last;
      }
      _authData['imagen'] = img;

    });


    Provider.of<Logros>(context, listen: false)
        .crearLogro(_authData)
        .then((value) => Navigator.pushReplacementNamed(
            context, '/listalogros'));
  }


  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context).settings.arguments as Map<String,String>;
    print(arg['id']);

    id = arg['id'];
     logro =
          Provider.of<Logros>(context, listen: false).findById(arg['id']);

      return Scaffold(
      appBar: AppBar(          title: Text("Editar logro"),
      ),
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
                  ) : logro.imagen != null
                      ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "http://${IP.ip}:5000/img/${logro.imagen}")),
                    ),
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
                margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                child: TextFormField(
                  initialValue: logro.nombre,
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

                        initialValue: logro.descripcion,
                      onSaved: (value){
                        _authData['descripcion'] = (value);
                      },
                      decoration:
                      InputDecoration(labelText: "Descripción"),
                    ),

                  ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    await submit();
                  },
                  child: Text(
                    "Crear Logro",
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
