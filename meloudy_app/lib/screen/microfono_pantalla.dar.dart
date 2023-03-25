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

  List<String> notascorrectas = [];
  List<String> respuestas = [];

  int indice = 0;
  FlutterFft flutterFft = new FlutterFft();

  @override
  void setState(fn) {
    if (mounted) {
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

    var ind = Provider.of<Preguntas>(context, listen: false).indice;

    var respuestascargadas = Provider.of<Preguntas>(context, listen: false)
        .preguntas[ind]
        .respuestas;
    notascorrectas = Provider.of<Preguntas>(context, listen: false)
        .preguntas[ind]
        .respuestascorrectas;

    indice = respuestas.length;
    for (var i = 0; i < respuestascargadas.length; i++) {
      print(respuestascargadas[i]);
      respuestas.add(respuestascargadas[i]);
    }

    super.initState();
  }

  void repetir() {
    // Provider.of<Preguntas>(context, listen: false).vaciarRespuestas();

    setState(() {
      Provider.of<Preguntas>(context, listen: false).vaciarRespuestas();
      indice = 0;
      respuestas = [];
    });
  }

  _initialize() async {
    print("Starting recorder...");

    if (flutterFft.getIsRecording == true) {
      await flutterFft.stopRecorder();
      setState(() {
        isRecording = flutterFft.getIsRecording;
      });
    }
    await flutterFft.startRecorder();
    print("Recorder started...");

    setState(() => isRecording = flutterFft.getIsRecording);
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
                  if (!alt && indice < notascorrectas.length)
                    {
                      Provider.of<Preguntas>(context, listen: false)
                          .setRespuestas(note),
                      respuestas.add(note),
                      indice++,
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
  }

  parar() async {
    await flutterFft.stopRecorder();
    setState(() {
      isRecording = flutterFft.getIsRecording;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (flutterFft.getIsRecording) {
      flutterFft.stopRecorder();
      setState(() {
        isRecording = flutterFft.getIsRecording;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isRecording = flutterFft.getIsRecording;

    final modo = Provider.of<Preguntas>(context, listen: false).modo;
    indice = respuestas.length;

    if (indice == notascorrectas.length && isRecording) {
      flutterFft.stopRecorder();
      setState(() {
        isRecording = flutterFft.getIsRecording;
      });
    }
    List<Widget> notas = [];

    for (var i = 0; i < notascorrectas.length; i++) {
      notas.add(Text(
        i < respuestas.length ? respuestas[i] : "???",
        style: TextStyle(
            color: i < respuestas.length ? modo == 'revisando' ? respuestas[i] == notascorrectas[i] ? Colors.green : Colors.red : Colors.blue : Colors.blue,
            fontWeight:
                i < respuestas.length ? FontWeight.bold : FontWeight.normal,
                fontSize:
                i == respuestas.length ? 35 : 30,
        ),
      ));
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...notas,
          modo == 'respondiendo' ? Container(
            child: Column(children: [
          Container(
              child: isRecording
                  ? Icon(
                      Icons.mic_rounded,
                      size: 60,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.mic_off_rounded,
                      size: 60,
                      color: Colors.red,
                    )),
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
                  : () {
                      var ind =
                          Provider.of<Preguntas>(context, listen: false).indice;
                      print(Provider.of<Preguntas>(context, listen: false)
                          .preguntas[ind]
                          .respuestas
                          .toString());
                    },
              child: Text("PARAR MICRÓFONO")),

              isRecording
                  ? Text(
                      "Nota: $note",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  : Text(
                      "",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
              isRecording
                  ? Text(
                      "Frecuencia: ${frequency.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )
                  : Text(
                      "",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
            ]),
          ) : Container(),
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
}
