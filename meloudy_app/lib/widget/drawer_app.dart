import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/pantalla_lecciones.dart';
import 'package:meloudy_app/screen/pantalla_dashboard.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/usuario_perfil.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Provider.of<Auth>(context, listen: false).getRol);
    return Drawer(
      key: GlobalKey<ScaffoldState>(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => Column(
          children: <Widget>[
            AppBar(
              title: Text('MELOUDY'),
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              key: Key('inicio'),
              title: Text('Inicio'),
              onTap: () {
                if(auth.isAuth) Navigator.of(context).pushReplacementNamed('/lecciones');
                else Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            if(auth.isAuth) Divider(),
            if(auth.isAuth) ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              key: Key('perfil'),

              onTap: () {

                var idUsuario =
                    Provider.of<Auth>(context, listen: false).userId;
                Provider.of<UsuarioPerfil>(context, listen: false).fetchAndSetUser(idUsuario).then((_) =>
                    Navigator.pushNamed(context, '/usuario'));


              },
            ),
            if (auth.getRol == "Profesor")
              Column(children: [
                Divider(),
                ListTile(
                  key: Key('dashboard'),
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(PantallaDashboard.routeName);
                  },
                ),
              ]),
            if(auth.isAuth) Divider(),
            if(auth.isAuth) ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () {
                Navigator.of(context).pop();

                // Navigator.of(context)
                //     .pushReplacementNamed(UserProductsScreen.routeName);
                Provider.of<Auth>(context, listen: false)
                    .logout()
                    .then((result) {
                  Navigator.pushReplacementNamed(context, '/');
                });
              },
            ),
            if(!auth.isAuth)
              Divider(),
          ],
        ),
      ),
    );
  }
}
