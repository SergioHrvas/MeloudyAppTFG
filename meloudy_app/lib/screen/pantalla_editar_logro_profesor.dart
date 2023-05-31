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

  var leccionelegida = "";
  var nombreslecciones = [""];
  var lecciones = [];
  Map<String, String> leccionesmap = {};


  PickedFile _image;
  File file;
  var primeravez = true;
  var primeravez2 = true;
  var tipo = "amigos";
  final tipos = [
    "amigos",
    "tests",
    "leccion",
    "lecciones",
    "preguntasunica",
    "preguntastexto",
    "preguntasmultiple",
    "preguntasmicro"
  ];
  var condicion;

  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _extractedData = {};

  var id;
  var logro;

  @override
  void initState() {
    // TODO: implement initState
    nombreslecciones = [];
    lecciones = Provider.of<Lecciones>(context, listen: false).items;
    for (var i = 0; i < lecciones.length; i++) {
      print("d");
      nombreslecciones.add(lecciones[i].nombre);
      leccionesmap[lecciones[i].nombre] = lecciones[i].id;
    }

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
      _extractedData['imagen'] = img;
      _extractedData["tipo"] = tipo;
      if(tipo == 'leccion') {
        _extractedData["condicion"] = leccionesmap[leccionelegida];
      }

    });

  var indice = 0;
    Provider.of<Logros>(context, listen: false)
        .editarLogro(_extractedData, id)
        .then((value) => Navigator.popUntil(
            context, (_) => indice++>=2 )).then((value){
              Navigator.pushNamed(context, '/listalogrosprofesor');
    });
  }


  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context).settings.arguments as Map<String,String>;

    id = arg['id'];
    logro = Provider.of<Logros>(context, listen: false).findById(arg['id']);

    print(logro.tipo);
    print(logro.condicion);



     if(primeravez) {
       tipo = logro.tipo;
     }

     if(primeravez2){
       if(logro.tipo == "leccion")
         leccionelegida = Provider.of<Lecciones>(context, listen: false).findById(logro.condicion).nombre;
          print(leccionelegida);
          if(leccionelegida==""){
            print(lecciones.toString());
            leccionelegida = lecciones[0].nombre;
          }
     }



     condicion = logro.condicion;

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
                    _extractedData['nombre'] = value;
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
                        _extractedData['descripcion'] = (value);
                      },
                      decoration:
                      InputDecoration(labelText: "Descripción"),
                    ),

                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text("Tipo:"),
                        ),
                        DropdownButton(

                          items:
                          tipos.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newvalue) {
                            setState(() {
                              tipo = newvalue;
                              primeravez = false;
                            });
                          },
                          value: tipo,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 40, left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(tipo == "leccion"
                              ? "ID"
                              : tipo == "lecciones"
                              ? "Nro Lecciones >= "
                              : tipo == "amigos"
                              ? "Nro Amigos >= "
                              : tipo == "tests" ? "Nro Tests >= " : "Nro Preguntas >= "),
                        ),
                        (tipo != "leccion") ?
                        Expanded(
                          child: TextFormField(
                            initialValue: condicion.toString(),
                            onSaved: (value) {
                              if(tipo != "leccion")
                                _extractedData['condicion'] = int.parse(value);
                            },
                            decoration: InputDecoration(labelText: "Condicion"),
                          ),
                        )
                            : Expanded(
                            child: DropdownButton(
                                items: nombreslecciones
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    leccionelegida = value;
                                    primeravez2 = false;
                                  });
                                },
                                value: leccionelegida)),
                      ],
                    ),
                  ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    await submit();
                  },
                  child: Text(
                    "Editar Logro",
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
