import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ips.dart';
import '../providers/leccion.dart';
import '../providers/lecciones.dart';
import '../providers/preguntas.dart';
import '../widget/drawer_app.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PantallaFinalTest extends StatefulWidget {
  static const routeName = '/testacabado';

  @override _PantallaFinalTestState createState() => _PantallaFinalTestState();

}


class _PantallaFinalTestState extends State{
  var _isLoading = false;
  var idTest;

  _PantallaFinalTestState();

  @override
  void didChangeDependencies() {


    idTest = Provider.of<Preguntas>(context, listen:false).testId;
    Provider.of<Preguntas>(context, listen:false).calcularAciertos();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final leccionId =
    ModalRoute.of(context).settings.arguments as String; // is the id!

    final leccion = Provider.of<Lecciones>(
      context,
      listen: false,
    ).findById(leccionId);

    final aciertos = Provider.of<Preguntas>(context, listen: false).getAciertos();
    return Scaffold(
      appBar: AppBar(title: Text("MELOUDY")),
      drawer: DrawerApp(),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView( child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 100, margin: EdgeInsets.only(bottom: 12), child: Image.network('http://${IP.ip}:5000/img/${leccion.imagenprincipal}')),
            Container(margin: EdgeInsets.only(bottom: 25), child: Text("Has completado un test de la lección ${leccion.nombre} con ${aciertos}/10 aciertos.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Container(margin: EdgeInsets.only(bottom: 15), child: CircularPercentIndicator(radius: 70.0,
              lineWidth: 10.0,
              percent: aciertos/10,
              center: new Text("${aciertos/10*100}%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              progressColor: aciertos > 8 ? Colors.blue : aciertos > 5 ? Colors.orangeAccent : Colors.red,
            )),
              Container(child: FutureBuilder(
               future: Provider.of<Preguntas>(context,listen:false).enviarTest(),
                  builder: (ctx, snapshot){
                 if (snapshot.connectionState != ConnectionState.waiting){
                   idTest = snapshot.data;
                   return Container(child: ElevatedButton(onPressed: (){
                     Provider.of<Preguntas>(context, listen: false).setModo('revisando');
                     Navigator.pushReplacementNamed(context, '/pregunta');
                   }, child: Text("Revisar",        key: Key('revisar'),
                   ),),);
    }
                 else{
                   return CircularProgressIndicator();
    }

    }
              ),

              ),

          ],
        ),
              ),
      ),
    );
  }
}
