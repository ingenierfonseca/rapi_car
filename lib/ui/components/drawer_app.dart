import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/ui/views/home/car/car_register_view.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                    image: NetworkImage('https://avatars1.githubusercontent.com/u/16735800?s=460&u=c7b12bcf27536fb5bef9c880aaa17d4b0c7ff45d&v=4'),
                    placeholder: R.image.loading_gif(),
                    fit: BoxFit.fill,
                    height: 100,
                  ) 
                ),
                SizedBox(height: 10),
                Text('Marlon Fonseca', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            /*decoration: BoxDecoration(
              color: Colors.purpleAccent,
            )*/
          ),
          /*ListTile(
            title: Text('Vehículos'),
            onTap: () {
              Navigator.pushNamed(context, 'car_register');
            },
          ),*/
          _createDrawerItem(icon: Icons.home, text: 'Inicio'),
          //_createDrawerItem(icon: Icons.home, text: 'Inicio'),
          //_createDrawerItem(icon: Icons.home, text: 'Inicio'),
          _createDrawerItem(icon: Icons.format_align_left, text: 'Registrar Vehículo', onTap: () {Navigator.of(context).pop(); context.push(page: CarRegisterView());}),
          _createDrawerItem(icon: Icons.format_indent_decrease, text: 'Historial de Reservas'),
          _createDrawerItem(icon: Icons.settings, text: 'Configuración'),
          _createDrawerItem(icon: Icons.offline_share, text: 'Salir', onTap: () {
            AppService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          })
        ],
      ),
    );
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          SizedBox(width: 60),
          Icon(icon, color: Colors.pinkAccent),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  _onTap(BuildContext context, String route) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, route);
  }
}