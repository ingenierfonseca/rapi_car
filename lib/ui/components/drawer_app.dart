import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/core/services/app_service.dart';
import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/ui/views/home/car/bussines_car_view.dart';

import 'package:rapi_car_app/global/enviroment.dart';
import 'package:rapi_car_app/ui/views/home/history/rent_car_history.dart';

class DrawerApp extends StatefulWidget {
  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  final List<String> bussinessRoles = ['ADMIN_ROLE', 'BUSSINESS_ROLE']; 

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  }

  Widget _buildDrawer(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    
    return Drawer(
      child: ListView(
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
                    image: NetworkImage('${Enviroment.userUrl}/${authService.user.photo}'),
                    placeholder: R.image.loading_gif(),
                    fit: BoxFit.fill,
                    height: 100,
                  ) 
                ),
                SizedBox(height: 10),
                Text('${authService.user.name} ${authService.user.last_name}', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          _createDrawerItem(icon: Icons.home, text: 'Inicio', onTap: () => context.pop()),
          
          _bussinessWidget(bussinessRoles.contains(authService.user.role), context),
          
          _createDrawerItem(icon: Icons.format_indent_decrease, text: 'Historial Rentas', onTap: () => context.push(page: RentCarHistory())),
          _createDrawerItem(icon: Icons.settings, text: 'Configuración'),
          _createDrawerItem(icon: Icons.offline_share, text: 'Salir', onTap: () {
            AppService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          })
        ],
      ),
    );
  }

  Widget _bussinessWidget(isBussiness, BuildContext context) {
    if (isBussiness) {
      return Column(
        children: [
          _createDrawerItem(
            icon: Icons.format_align_left, 
            text: 'Mi cuenta de negocio', 
            onTap: () {
              Navigator.of(context).pop(); 
              context.push(page: BussinessCarView());
            }
          ),
          /*_createDrawerItem(
            icon: Icons.format_align_left, 
            text: 'Mis Vehículos', 
            onTap: () {
              Navigator.of(context).pop(); 
              context.push(page: CarRegisterView());
            }
          )*/
        ]
      );
    }

    return Container();
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
}