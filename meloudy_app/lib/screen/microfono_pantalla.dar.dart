
import 'dart:async';
import 'dart:core';


import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import '../providers/preguntas.dart';
import '../widget/drawer_app.dart';


class MicrofonoPantalla extends StatefulWidget {
  @override
  _MicrofonoPantallaState  createState() => _MicrofonoPantallaState ();
}

class _MicrofonoPantallaState  extends State<MicrofonoPantalla> {
  double frequency;
  String note;
  var alt = false;
  int octave;
  bool isRecording;
  List <String> acertadas = [];
  List<String> notascorrectas = [];
  List<String> respuestas = ["???", "???", "???", "???","???","???"];

  int indice = 0;
  FlutterFft flutterFft = new FlutterFft();


  Record myRecording = Record();
  Timer timer;

  double volume = 0.0;
  double minVolume = -45.0;

  @override
  void initState() {
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;
    notascorrectas.add('C');
    acertadas.add('U');
    notascorrectas.add('C');
    acertadas.add('U');

    notascorrectas.add('D');
    acertadas.add('U');

    notascorrectas.add('C');
    acertadas.add('U');

    notascorrectas.add('F');
    acertadas.add('U');

    notascorrectas.add('E');
    acertadas.add('U');
    super.initState();

    _initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isRecording
                    ? Text("Current note: ${note},${octave.toString()}",
                    style: TextStyle(fontSize: 30))
                    : Text("Not Recording", style: TextStyle(fontSize: 35)),
                isRecording
                    ? Text(
                    "Current frequency: ${frequency.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 30))
                    : Text("Not Recording", style: TextStyle(fontSize: 35))
              ],
            ),
    );
  }

  void repetir(){
    Provider.of<Preguntas>(context, listen: false).vaciarRespuestas();

    setState(() {
      acertadas = ["U","U","U","U","U","U" ];
      indice = 0;
      respuestas = ["???", "???", "???", "???","???","???"];
    });


  }
/*
  @override
  Widget build(BuildContext context) {
    _initialize();

    List <Widget> notas = [];

    for(var i = 0; i < notascorrectas.length; i++){
      notas.add(Text(indice < i ? "????" : respuestas[i], style: TextStyle(color: acertadas[i] == "T" ? Colors.blue : Colors.red, fontWeight: indice == i ? FontWeight.bold : FontWeight.normal),));
    }

    return
        Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isRecording
                    ? Text(
                  "Current note: $note",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                )
                    : Text(
                  "None yet",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                isRecording
                    ? Text(
                  "Current frequency: ${frequency.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                )
                    : Text(
                  "None yet",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                ...notas,
                ElevatedButton(onPressed: () async{
                 // _initialize();
                }, child: Text("EMPEZAR")),
                ElevatedButton(onPressed: (){
                  repetir();

                }, child: Text("REPETIR")),
                ElevatedButton(onPressed: () async {
                  if(flutterFft.getIsRecording){
                    await flutterFft.stopRecorder();
                  }
                }, child: Text("NO"))
              ],
            ),
        );
  }
*/
/*  getNota(data){
    print("as");
    if(data < 450 && data > 440){
      return 'G';
    }
    else{
      return 'T';
    }
  }
*/
  _initialize() async {
    print("Starting recorder...");

    await flutterFft.startRecorder();
    print("Recorder started...");

    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
          (data) => {
        setState(
              () => {
                if(data.length > 0){
                  frequency = data[1],
                  note = data[2],
                  octave = data[5] as int,
                },
                if(!alt){

                  print(notascorrectas),
                  print(notascorrectas[indice]),
                  print(note),
                  Provider.of<Preguntas>(context, listen: false).setRespuestas(note),

                  respuestas[indice] = note,
                  if(notascorrectas[indice] == note){
                    acertadas[indice] = 'T',
                    if(indice < notascorrectas.length - 1)
                      indice++
                  }
                  else
                    {
                      acertadas[indice] = 'F',
                      if(indice < notascorrectas.length - 1)
                        indice++},
                },
                alt = !alt
              },
        ),
        flutterFft.setNote = note,
        flutterFft.setFrequency = frequency,
        flutterFft.setOctave = octave,
      },
      onError: (err){
            print("ERROR: $err");
      },
      onDone: () => {print("Isdone")
          }
    );
    print("inddiceee");

  }

  parar() async{
    await flutterFft.stopRecorder();
  }
}
