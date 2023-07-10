import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import '../providers/preguntas.dart';
import 'drawer_app.dart';

class MicrofonoPregunta extends StatefulWidget {
  @override
  _MicrofonoPreguntaState createState() => _MicrofonoPreguntaState();
}

class _MicrofonoPreguntaState extends State<MicrofonoPregunta> {
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
    print("Empenzando a grabar...");

    if (flutterFft.getIsRecording == true) {
      await flutterFft.stopRecorder();
      setState(() {
        isRecording = flutterFft.getIsRecording;
      });
    }
    await flutterFft.startRecorder();
    print("Grabación empezada...");

    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
        (data) => {
              setState(
                () => {
                  if (data.length > 0)
                    {
                      frequency = data[1],
                      note = data[2] == 'A' ? "La" : data[2] == 'B' ? "Si" : data[2] == "C" ? "Do" : data[2] == "D" ? "Re" : data[2] == "E" ? "Mi" : data[2] == "F" ? "Fa" : data[2] == "G" ? "Sol" : "La",
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
        onDone: () => {print("Listo")});
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

    if(respuestas.length == 0 && modo == "revisando"){
      for(var i = 0; i < notascorrectas.length; i++){
        respuestas.add("-");
      }
    }
    if (indice == notascorrectas.length && isRecording) {
      flutterFft.stopRecorder();
      setState(() {
        isRecording = flutterFft.getIsRecording;
      });
    }
    List<Widget> notas = [];

    for (var i = 0; i < notascorrectas.length; i++) {
      notas.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          i < respuestas.length ? respuestas[i] != null ? respuestas[i] : "???" : "???",
          style: TextStyle(
            color: i < respuestas.length
                ? modo == 'revisando'
                    ? respuestas[i] == notascorrectas[i]
                        ? Colors.green
                        : Colors.red
                    : Colors.blue
                : Colors.blue,
            fontWeight:
                i == respuestas.length ? FontWeight.bold : FontWeight.normal,
            fontSize: i == respuestas.length ? 35 : 30,
          ),
        ),
      ));
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Wrap(
        children: [...notas]
      )),
          modo == 'respondiendo'
              ? Container(
                  child: Column(children: [
                    GestureDetector(
                      onTap: flutterFft.getIsRecording
                          ? () async {
                              if (flutterFft.getIsRecording) {
                                await flutterFft.stopRecorder();
                                setState(() =>
                                    isRecording = flutterFft.getIsRecording);
                              }
                            }
                          : () async {
                              _initialize();
                            },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: isRecording
                            ? Icon(
                                Icons.mic_rounded,
                                size: 70,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.mic_off_rounded,
                                size: 70,
                                color: Colors.red,
                              ),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid), borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          repetir();
                        },
                        child: Text("Limpiar")),
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
                )
              : Container(),
        ],
      ),
    );
  }

}
