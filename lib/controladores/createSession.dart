import 'package:flutter_session/flutter_session.dart';
import 'package:tpv/modelo/usuarioSesion.dart';

import 'accionesPrincipales.dart';

class CrearSesion{

   void  saveData(context) async {
    UsuarioSesion usuarioSesion = UsuarioSesion(firstName: "Juan", secondName: "Garcia");
    await FlutterSession().set('myData', usuarioSesion);
  }


}