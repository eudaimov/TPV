import 'dart:core';
import 'package:flutter_session/flutter_session.dart';

class UsuarioSesion {

  String firstName;
  String secondName;


  UsuarioSesion({this.firstName, this.secondName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["firstName"] = this.firstName;
    data["secondName"] = this.secondName;
    return data;
  }

}
