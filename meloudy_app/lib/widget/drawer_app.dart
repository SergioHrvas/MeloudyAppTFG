import 'package:flutter/material.dart';
import 'package:meloudy_app/screen/pantalla_dashboard.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/usuario_perfil.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              title: Text('Inicio'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
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
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(PantallaDashboard.routeName);
                  },
                ),
              ]),
            Divider(),
            ListTile(
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
          ],
        ),
      ),
    );
  }
}
