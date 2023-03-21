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
  _MicrofonoPantallaState createState() => _MicrofonoPantallaState();
}


class _MicrofonoPantallaState extends State<MicrofonoPantalla> {
  double frequency;
  String note;
  var alt = false;
  int octave;
  bool isRecording;
  List<String> acertadas = [];
  List<String> notascorrectas = [];
  List<String> respuestas = ["???", "???", "???", "???", "???", "???"];

  int indice = 0;
  FlutterFft flutterFft = new FlutterFft();

  @override
  void setState(fn){
    if(mounted){
      super.setState(fn);
    }
  }
  @override
  void initState() {
    print(flutterFft.getIsRecording);

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

  }

  void repetir() {
    // Provider.of<Preguntas>(context, listen: false).vaciarRespuestas();

    setState(() {
      acertadas = ["U", "U", "U", "U", "U", "U"];
      indice = 0;
      respuestas = ["???", "???", "???", "???", "???", "???"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> notas = [];

    for (var i = 0; i < notascorrectas.length; i++) {
      notas.add(Text(
        indice < i ? "????" : respuestas[i],
        style: TextStyle(
            color: acertadas[i] == "T" ? Colors.blue : Colors.red,
            fontWeight: indice == i ? FontWeight.bold : FontWeight.normal),
      ));
    }

    return Container(
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
          ElevatedButton(
              onPressed: flutterFft.getIsRecording == false
                  ? () async {
                      _initialize();
                    }
                  : () {},
              child: Text("EMPEZAR")),
          ElevatedButton(
              onPressed: () {
                repetir();
              },
              child: Text("REPETIR")),
          ElevatedButton(
              onPressed: flutterFft.getIsRecording
                  ? () async {
                      if (flutterFft.getIsRecording) {
                        await flutterFft.stopRecorder();
                        setState(() => isRecording = flutterFft.getIsRecording);
                        print(isRecording);
                      }
                    }
                  : () {},
              child: Text("NO"))
        ],
      ),
    );
  }

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
    print(flutterFft.getIsRecording);
    print("Recorder started...");

    setState(() => isRecording = flutterFft.getIsRecording);
    print(isRecording);
    flutterFft.onRecorderStateChanged.listen(
        (data) => {
              setState(
                () => {
                  if (data.length > 0)
                    {
                      frequency = data[1],
                      note = data[2],
                      octave = data[5] as int,
                    },
                  if (!alt)
                    {
                      print(notascorrectas),
                      print(notascorrectas[indice]),
                      print(note),
                      Provider.of<Preguntas>(context, listen: false).setRespuestas(note),

                      respuestas[indice] = note,
                      if (notascorrectas[indice] == note)
                        {
                          acertadas[indice] = 'T',
                          if (indice < notascorrectas.length - 1) indice++
                        }
                      else
                        {
                          acertadas[indice] = 'F',
                          if (indice < notascorrectas.length - 1) indice++
                        },
                    },
                  alt = !alt
                },
              ),
              flutterFft.setNote = note,
              flutterFft.setFrequency = frequency,
              flutterFft.setOctave = octave,
            },
        onError: (err) {
          print("ERROR: $err");
        },
        onDone: () => {print("Isdone")});
    print("inddiceee");
  }



  parar() async {
    await flutterFft.stopRecorder();
  }
}
