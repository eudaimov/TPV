import 'package:flutter_session/flutter_session.dart';
import 'package:tpv/modelo/usuarioSesion.dart';

import 'accionesPrincipales.dart';

class CrearSesion{

  String nombre;
  String apellidos;
  String password;

  CrearSesion(this.nombre, this.apellidos, this.password);

   void  saveData(context) async {
    UsuarioSesion usuarioSesion = UsuarioSesion(firstName: this.nombre, secondName: "Garcia", password: this.password);
    await FlutterSession().set('myData', usuarioSesion);
  }


}