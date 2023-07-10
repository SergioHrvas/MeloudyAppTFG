import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../ips.dart';

class SubirImagen extends StatelessWidget{
  var indice;
  final f;
  final funcionImagen;
  final tipo = "img";
  var datos = "";

  SubirImagen(this.indice, this.f, this.funcionImagen, this.datos);

  void cambiarIndice(i){
    indice = i;
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        SubirImagenFul(this.funcionImagen, this.datos),
        GestureDetector(onTap: (){
          f(indice);
        },
            child: Icon(Icons.delete_forever, size: 40, color:Colors.red,))
      ],
    );
  }
}

class SubirImagenFul extends StatefulWidget{

  final funcionImagen;
  final datos;
  SubirImagenFul(this.funcionImagen, this.datos);

  @override
  _SubirImagenState createState() =>
      _SubirImagenState(this.funcionImagen, this.datos);
}

class _SubirImagenState extends State<SubirImagenFul>{

  PickedFile image;
  File file;
  var datos;
  final funcionImagen;

  _SubirImagenState(this.funcionImagen, this.datos);

  final ImagePicker picker = ImagePicker();





  Future getImage(ImageSource media) async {
    var img = await picker.getImage(source: media);
    setState(() {
      file = File(img.path);
      image = img;
    });

    funcionImagen(img, file);
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.only(top: 30),

      child: Column(
        children: [


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              file == null ? ElevatedButton(onPressed: (){

                getImage(ImageSource.gallery);


              }, child: Text("Subir imagen")) : Container(),
              Container(
                width: 120,
                child: file != null ? Image.file(File(file.path)) : this.datos != "" ? Image.network('http://${IP.ip}:5000/img/${this.datos}') : Container(),
              ),
            ],
          ),


        ],
      ),
    );
  }
  
}