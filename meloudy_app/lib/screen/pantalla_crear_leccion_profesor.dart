import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meloudy_app/image_controller.dart';
import 'package:meloudy_app/providers/lecciones.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/auth.dart';
import '../providers/preguntas_profesor.dart';
import '../widget/drawer_app.dart';
import '../widget/subir_imagen.dart';
import '../widget/subir_texto.dart';
import '../widget/subir_titulo.dart';
import 'package:http/http.dart' as http;

class PantallaCrearLeccionProfesor extends StatefulWidget {
  static const routeName = '/crearleccion';

  @override
  _PantallaCrearLeccionProfesorState createState() =>
      _PantallaCrearLeccionProfesorState();
}

class _PantallaCrearLeccionProfesorState
    extends State<PantallaCrearLeccionProfesor> {
  _PantallaCrearLeccionProfesorState();
  PickedFile _image;
  File file;

  final ImagePicker picker = ImagePicker();
  var partes = [];

  var indice = 0;
  var imgs = [];
  var ind = 0;

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _authData = {};


  Future getImage(ImageSource media) async {
    var img = await picker.getImage(source: media);

    setState(() {

      file = File(img.path);
      _image = img;
    });
  }

  int getProximaImagen(ind){
    for(var i = ind; i < _authData['contenido'].length; i++){
      if(_authData['contenido'][i]['tipo'] == 'img'){
        return i;
      }
    }
    return -1;
  }

  int getIndiceImagen(ind){
    var contador = -1;
    for(var i = 0; i < partes.length; i++){
      if(partes[i].child.tipo.toString() == 'img'){
        contador++;
      }
    }
    return contador;
  }

  void borrar(i) {
    setState(() {
      if(partes[i].child.tipo.toString() == 'img' && partes[i].child.datos != ""){
        var j = getIndiceImagen(i);
        imgs.removeAt(j);
      }
      partes.removeAt(i);
      for (var j = i; j < partes.length; j++) {
        partes[j].child.cambiarIndice(i);
      }
      indice--;
    });
  }

  void submit() async{
    List<Map<String, String>> vectordatos = [];

    for(var i = 0; i < partes.length; i++){
       vectordatos.add({
        'tipo':partes[i].child.tipo.toString(),
        'texto':partes[i].child.datos.toString(),
      });
    _authData['contenido'] = vectordatos;
    }


    _formKey.currentState.save();


    var token = Provider.of<Auth>(context, listen: false).token;

    for(var i = 0; i < imgs.length; i++){
      await ImageController().upload(imgs[i]['img'], token).then((_){
        var img;
        if(imgs[i]['img'] == null){
          img = "musica.png";
        }
        else{
          img = imgs[i]['file'].path.split('/').last;
        }
        var j = getProximaImagen(ind);
        ind = j;
        _authData['contenido'][ind]['texto'] =  img;
        ind++;
      });
    }
    await ImageController().upload(_image, token).then((_){
      var img;
      if(_image == null){
        img = "musica.png";
      }
      else{
        img =  file.uri.path.split('/').last;
      }
      _authData['imagenprincipal'] = img;

      Provider.of<Lecciones>(context,listen: false).crearLeccion(_authData).then((value) =>
        Navigator.pushReplacementNamed(context, '/leccionesPantallaProfesor')
    );});


  }

  void funcionImagen(img, file){
    imgs.add({"img": img, "file": file});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerApp(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top: 20),

            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 250,
                child: TextFormField(
                  onSaved: (value){
                    _authData['nombre']=value;
                  },
                  decoration: InputDecoration(labelText: "Nombre de la lección"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(bottom: 5, top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
                width: 230,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, bottom: 5, top: 5),
                alignment:Alignment.topCenter,
                      child: Container(child: Text("Imagen principal", style: TextStyle(color: Colors.grey, fontSize: 18),)),
                    ),
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



                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: EdgeInsets.only(left: 8, right: 8),
                decoration: partes.length!=0 ? BoxDecoration(
                  border: Border.all(color: Colors.black)
                ) : BoxDecoration(),
                child: Column(children: [...partes]),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          partes.add(
                            Container(
                              width: 350,
                                child: SubirImagen(indice, borrar, funcionImagen, "")),
                          );
                          indice++;
                        });
                      },
                      child: Container(
                          child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                      )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          partes.add(
                            Container(child: SubirTexto(indice, borrar, "")),
                          );
                          indice++;
                        });
                      },
                      child: Container(
                          child: Icon(
                        Icons.add_comment_outlined,
                        size: 40,
                      )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          partes.add(
                            Container(child: SubirTitulo(indice, borrar, "", "Introduzca el título del apartado")),
                          );
                          indice++;
                        });
                      },
                      child: Container(
                          child: Icon(
                        Icons.add_comment,
                        size: 40,
                      )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          partes.add(Container(
                            child: Text("AÑADIR IMAGEN"),
                          ));
                        });
                      },
                      child: Container(
                          child: Icon(
                        Icons.video_collection,
                        size: 40,
                      )),
                    ),
                  ],
                ),
              ),
              Container(                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(onPressed: () async{
                  await submit();
                  }
                ,
                child: Text("Crear Lección", style: TextStyle(fontSize: 20),),),)
            ]),
          ),
        ),
      ),
    );
  }
}
