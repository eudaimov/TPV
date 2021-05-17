import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:tpv/paginas/usuario.dart';

import 'carta.dart';
import 'login.dart';
import 'menuPrincipal.dart';

class Routes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RoutesState();
}

class RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPV IN',
      debugShowCheckedModeBanner: false,
      routes: {
        "/menuPrincipal": (BuildContext context) => redireccionamiento(MenuPrincipal()),
        "/login": (BuildContext context) => redireccionamiento(MenuPrincipal()),
        "/carta": (BuildContext context) => redireccionamiento(Carta()),
        "/formularioUsuario": (BuildContext context) => redireccionamiento(FichaUsuario()),
      },
      initialRoute: "/login",
    );
  }

  Future<bool> comprobarSesion(context) async {
    dynamic token = await FlutterSession().get("myData");
    //TODO Quitar password es simplemente para falsear el login pero se necesita comprobar la identificación
    if (token['firstName'] == "Felix" && token['password']=='1234') {
      return true;
    } else {
      print("Falso");
      return false;
    }
  }

  FutureBuilder redireccionamiento(Widget posible){
    return FutureBuilder(
        future: comprobarSesion(context),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data) {
              return posible;
            } else {
              return Login();
            }
          } else {
            return Login();
          }
        });
  }
}
