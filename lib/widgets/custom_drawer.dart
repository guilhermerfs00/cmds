import 'package:cmds/models/user_model.dart';
import 'package:cmds/screens/login_screen.dart';
import 'package:cmds/tile/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );

    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Drawer(
          child: Stack(
            children: <Widget>[
              _buildDrawerBack(),
              ListView(
                padding: EdgeInsets.only(left: 32.0, top: 16.0),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                    height: 170,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 20.0,
                          left: 0.0,
                          child: Text(
                            'CMDS',
                            style: TextStyle(fontSize: 34.0),
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Bem vindo !',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  DrawerTile(Icons.home, 'Início', () {
                    print('Inicio');
                  }),
                  DrawerTile(Icons.dashboard, 'Dashboard', () {
                    print('DashBoard');
                  }),
                  DrawerTile(Icons.notifications, 'Notificações', () {
                    print('Notificação');
                  }),
                  DrawerTile(Icons.exit_to_app, 'Sair', () {
                    model.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
