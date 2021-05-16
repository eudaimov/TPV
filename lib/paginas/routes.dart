
import 'package:flutter/material.dart';
import 'package:tpv/paginas/usuario.dart';

import 'carta.dart';
import 'login.dart';
import 'menuPrincipal.dart';



class Routes extends StatelessWidget{
  bool _logueado = true;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'TPV IN',
        debugShowCheckedModeBanner: false,
        routes: {
          "/menuPrincipal": (BuildContext context) => MenuPrincipal(),
          "/login":(BuildContext context) => Login(),
          "/carta":(BuildContext context) => Carta(),
          "/formularioUsuario":(BuildContext context) => FichaUsuario(),
        },
        initialRoute: _logueado ? "/carta": "/login",
      //TODO cambiar pagina registrar por principal
    );
  }

}