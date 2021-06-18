import 'dart:convert';
import 'package:http/http.dart' as http;

class Peticiones {

  Map<String, String> cuerpo;
  String url;

  Peticiones(this.url);

  Future<String> identificarse(Map<String,String> usuario) async {
    print(jsonDecode(jsonEncode(usuario)));
    var url = Uri.parse(this.url);

    var response = await http.post(
        url,
        body: jsonEncode(usuario),
        headers: {"Content-Type": "application/json"}
    );
    //print('Response status: ${response.statusCode}');
    print("La respuesta es "+ response.body);
    return response.body;
  }

  Future<String> addUser(Map<String,String> usuario) async {
    var url = Uri.parse(this.url);
    var response = await http.post(
        url,
        body: jsonEncode(usuario),
        headers: {"Content-Type": "application/json"}
        );
      //print('Response status: ${response.statusCode}');
    return response.body;
  }
  Future<String> peticionPut() async {


    var url = Uri.parse(this.url);
    Map<String, String > cuerpo = {
      "id": "10",
      "nick": "Cambiado",
      "nombre": "change",
      "apellidos": "García Sánchez",
      "password": "3256876",
      "fechaNacimiento": "01-12-2020",
      "direccion": "Calle Nelson Mandela nº4, Bajo Izquierda",
      "poblacion": "Alcorcón",
      "provincia": "Madrid",
      "codigoPostal": "28922",
      "numeroTelefono": "916414231",
      "email": "micorreo@correo.com"
    };
    var response = await http.put(url, body: jsonEncode(cuerpo), headers: {
      "Content-Type": "application/json"}
    );

    //print('Response status: ${response.statusCode}');
    return response.body;


  }

  Future<String> eliminar(String id) async {

    var url = Uri.parse(this.url+"?id="+id);
    var response = await http.delete(url);
   return response.statusCode.toString();


  }
}