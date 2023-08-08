import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:meloudy_app/widget/subir_titulo.dart';
import 'package:provider/provider.dart';

import '../image_controller.dart';
import '../ips.dart';
import '../providers/auth.dart';
import '../providers/notas.dart';
import '../providers/opciones.dart';
import '../providers/preguntas.dart';
import '../providers/preguntas_profesor.dart';
import '../widget/drawer_app.dart';
import '../widget/subir_notas.dart';
import '../widget/subir_opcion.dart';

class PantallaEditarPreguntaProfesor extends StatefulWidget {
  static const routeName = '/editarpregunta';

  @override
  _PantallaEditarPreguntaProfesorState createState() =>
      _PantallaEditarPreguntaProfesorState();
}

class _PantallaEditarPreguntaProfesorState
    extends State<PantallaEditarPreguntaProfesor> {
  _PantallaEditarPreguntaProfesorState();

  PickedFile _image;
  File file;

  final ImagePicker picker = ImagePicker();

  var primeravez = true;
  var opciones = [];
  var indice = 0;
  var id;
  var s = 0;
  String leccion = "Introducción";
  Map<String, String> lecciones = {};
  String tipo;
  final tipos = ["unica", "multiple", "microfono", "texto"];

  var opcioneswidgets = [];

  var pregunta;
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _authData = {};


  Future getImage(ImageSource media) async {
    var img = await picker.getImage(source: media);

    setState(() {
      file = File(img.path);
      _image = img;
    });
  }

  void borrar(i) {
    setState(() {
      opciones.removeAt(i);

      for (var j = i; j < opciones.length; j++) {
        opciones[j].child.cambiarIndice(i);
      }
      indice--;

      if (tipo != "microfono") {
        Provider.of<Opciones>(context, listen: false).borrarOpcion(i);
      } else {
        Provider.of<Notas>(context, listen: false).borrarNota(i);
      }


    });
  }

  void submit() async {
    List<Map<String, String>> vectordatos = [];
    _formKey.currentState.save();

    for (var i = 0; i < opciones.length; i++) {
      vectordatos.add({
        'texto': opciones[i].child.datos.toString(),
      });
      _authData['contenido'] = vectordatos;
    }

    _formKey.currentState.save();

    var token = Provider.of<Auth>(context, listen: false).token;

    await ImageController().upload(_image, token).then((_) {
      var img;
      if (_image == null) {
        img = pregunta.imagen;
      } else {
        img = file.uri.path.split('/').last;
      }
      _authData['imagen'] = img;
    });

    _authData['leccion'] = lecciones[leccion];

    if (tipo == 'multiple' || tipo == 'unica') {
      var respuestascorrectas =
          Provider.of<Opciones>(context, listen: false).opciones;

      var resp = [];
      for (var i = 0; i < respuestascorrectas.length; i++) {
        if (respuestascorrectas[i] == true) {
          resp.add(i);
        }
      }
      _authData['respuestascorrectas'] = resp;

      _authData['opciones'] =
          Provider.of<Opciones>(context, listen: false).itemsTexto;
    } else if (tipo == 'microfono') {
      List<String> respuestasmicro =
          Provider.of<Notas>(context, listen: false).items;
      _authData['respuestascorrectas'] = respuestasmicro;
    }

    var indice = 0;
    Provider.of<PreguntasProfesor>(context, listen: false)
        .actualizarPregunta(_authData, id)
        .then((value) =>
            Navigator.popUntil(context, (_) => indice++ >= 2 )).then((value){
              Navigator.pushNamed(context, "/listapreguntas");
            });
  }

  @override
  Widget build(BuildContext context) {
    indice = 0;
    var arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    opciones = [];
    id = arg['id'];

    pregunta = Provider.of<PreguntasProfesor>(context, listen: false)
        .findById(arg['id']);
    tipo = pregunta.tipo;
    var lecc = Provider.of<Lecciones>(context, listen: false).items;

    for (var i = 0; i < lecc.length; i++) {
      if (lecciones == null) {
        lecciones = {lecc[i].nombre: lecc[i].id};
      } else {
        lecciones.addAll({lecc[i].nombre: lecc[i].id});
      }
    }
    if (primeravez) {
      leccion =
          lecc.firstWhere((element) => (element.id == pregunta.leccion)).nombre;
    }

    var opcionestexto =
        Provider.of<Opciones>(context, listen: false).opcionesTexto;

    var opcionescorrectas;

    if (pregunta.tipo == 'multiple' ||
        pregunta.tipo == 'unica' ||
        pregunta.tipo == 'texto') {
      opcionescorrectas =
          Provider.of<Opciones>(context, listen: false).opciones;
    } else if (pregunta.tipo == 'microfono') {
      opcionescorrectas = Provider.of<Notas>(context, listen: false).items;
    }
    if (pregunta.tipo == 'multiple' || pregunta.tipo == 'unica') {
      for (var i = 0; i < opcionestexto.length; i++) {
        opciones.add(Container(
          key: Key((s++).toString()),
            child: SubirOpcion(indice, tipo, borrar, opcionestexto[i])));
        indice++;
      }
    } else if (pregunta.tipo == 'microfono') {
      for (var i = 0; i < opcionescorrectas.length; i++) {
        opciones.add(
            Container(
                key: Key((s++).toString()),
                child: SubirNotas(indice, borrar, opcionescorrectas[i])));
        indice++;
      }
    }

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
              file != null
                  ? Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(file.path))),
                      ),
                    )
                  : pregunta.imagen != null
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
                                    "http://${IP.ip}:5000/img/${pregunta.imagen}")),
                          ),
                        )
                      : Container(),
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
                  items: lecciones.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newvalue) {
                    setState(() {
                      primeravez = false;
                      leccion = newvalue;
                      lecciones.clear();
                    });
                  },
                  value: leccion,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                child: TextFormField(
                  initialValue: pregunta.cuestion,
                  onSaved: (value) {
                    _authData['cuestion'] = value;
                  },
                  decoration:
                      InputDecoration(labelText: "Cuestión de la pregunta"),
                ),
              ),
              (tipo == "unica" || tipo == "multiple")
                  ? Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: opciones.length != 0
                          ? BoxDecoration(
                              border: Border.all(color: Colors.black))
                          : BoxDecoration(),
                      child: Column(children: [...opciones]),
                    )
                  : tipo == "texto"
                      ? Container(
                          margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: TextFormField(
                            initialValue: opcionescorrectas[0],
                            onSaved: (value) {
                              _authData['respuestascorrectas'] = [value];
                            },
                            decoration: InputDecoration(
                                labelText: "Respuesta de la pregunta"),
                          ),
                        )
                      : tipo == "microfono"
                          ? Container(
                              child: Column(
                              children: [...opciones],
                            ))
                          : Container(),
              (tipo == "unica" || tipo == "multiple" || tipo == "microfono")
                  ? Container(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              opciones.add(Container(
                                key: Key((s++).toString()),
                                  margin: EdgeInsets.only(top: 10),
                                  child: (tipo == "unica" || tipo == "multiple")
                                      ? SubirOpcion(indice, tipo, borrar, "")
                                      : SubirNotas(this.indice, borrar, "")));
                              indice++;
                              if (tipo == 'unica' || tipo == "multiple") {
                                Provider.of<Opciones>(context, listen: false)
                                    .anadirOpcion();
                              } else if (tipo == 'microfono') {
                                Provider.of<Notas>(context, listen: false)
                                    .anadirNota();
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Icon(
                              Icons.add_box,
                              size: 45,
                              color: Colors.blue,
                            ),
                          )),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    await submit();
                  },
                  child: Text(
                    "Actualizar Lección",
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
