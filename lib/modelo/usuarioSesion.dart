import 'dart:core';
import 'package:flutter_session/flutter_session.dart';

class UsuarioSesion {

  String firstName;
  String secondName;
  String password;


  UsuarioSesion({this.firstName, this.secondName, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["firstName"] = this.firstName;
    data["secondName"] = this.secondName;
    data["password"]=this.password;
    return data;
  }

}
