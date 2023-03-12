import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/leccion.dart';
import '../providers/lecciones.dart';
import '../providers/preguntas.dart';
import '../widget/drawer_app.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestAcabadoPantalla extends StatefulWidget {
  static const routeName = '/testacabado';

  @override _TestAcabadoPantallaState createState() => _TestAcabadoPantallaState();

}


class _TestAcabadoPantallaState extends State{
  var _isLoading = false;
  var idTest;

  _TestAcabadoPantallaState();

  @override
  void didChangeDependencies() {


    idTest = Provider.of<Preguntas>(context, listen:false).testId;
    Provider.of<Preguntas>(context, listen:false).calcularAciertos();
    print(Provider.of<Preguntas>(context, listen: false).getAciertos());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final leccionId =
    ModalRoute.of(context).settings.arguments as String; // is the id!

    print("l" + leccionId.toString());
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
            Container(width: 100, margin: EdgeInsets.only(bottom: 12), child: Image.asset('assets/${leccion.imagenprincipal}')),
            Container(margin: EdgeInsets.only(bottom: 25), child: Text("Has completado un test de la lección ${leccion.nombre} con ${aciertos}/10 aciertos.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Container(margin: EdgeInsets.only(bottom: 15), child: CircularPercentIndicator(radius: 70.0,
              lineWidth: 10.0,
              percent: aciertos/10,
              center: new Text("${aciertos/10*100}%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              progressColor: Colors.blue,
            )),
              Container(child: FutureBuilder(
               future: Provider.of<Preguntas>(context,listen:false).enviarTest(),
                  builder: (ctx, snapshot){
                 if (snapshot.connectionState != ConnectionState.waiting){
                   idTest = snapshot.data;
                   return Container(child: ElevatedButton(onPressed: (){
                     Provider.of<Preguntas>(context, listen: false).setModo('revisando');
                     Navigator.pushReplacementNamed(context, '/pregunta');
                   }, child: Text("Revisar"),),);
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
