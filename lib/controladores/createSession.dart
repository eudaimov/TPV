import 'package:flutter_session/flutter_session.dart';
import 'package:tpv/modelo/usuarioSesion.dart';


class CrearSesion{

   void  userSession(context, UsuarioSesion miUsuario) async {
      await FlutterSession().set('userLogin', miUsuario);
  }
  void activeSession(context) async{
     await FlutterSession().set('login', 'true');
  }
   void offSession(context) async{
     await FlutterSession().set('login', 'false');
   }


}