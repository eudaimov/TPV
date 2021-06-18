import 'dart:core';

class UsuarioSesion {

  int id;
  String nick;
  String nombre;
  String apellidos;
  String password;
  String fechaNacimiento;
  String direccion;
  String poblacion;
  String provincia;
  String codigoPostal;
  String numeroTelefono;
  String email;

  void fromJson(Map<String, dynamic> json){
    id = json['id'];
    nick = json['nick'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    password = json['password'];
    fechaNacimiento = json['fechaNacimiento'];
    direccion = json['direccion'];
    poblacion = json['poblacion'];
    provincia = json['provincia'];
    codigoPostal = json['codigoPostal'];
    numeroTelefono = json['numeroTelefono'];
    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultado = Map<String, dynamic>();
    resultado["id"] = this.id;
    resultado["nick"] = this.nick;
    resultado["nombre"] = this.nombre;
    resultado["apellidos"] = this.apellidos;
    resultado["password"] = this.password;
    resultado["fechaNacimiento"] = this.fechaNacimiento;
    resultado["direccion"] = this.direccion;
    resultado["poblacion"] = this.poblacion;
    resultado["provincia"] = this.provincia;
    resultado["codigoPostal"] = this.codigoPostal;
    resultado["numeroTelefono"] = this.numeroTelefono;
    resultado["email"] = this.email;

    return resultado;
  }

}
