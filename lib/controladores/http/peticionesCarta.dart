import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tpv/configuracion/configuraciones.dart';
import 'package:tpv/modelo/productojson.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:async';



class PeticionesCarta{


  Future<int> addProduct(Map<String,dynamic> productoNuevo) async {

    var url = Uri.parse(Config.hostbase+"productos");
    var response = await http.post(
        url,
        body: jsonEncode(productoNuevo),
        headers: {"Content-Type": "application/json"}
    );
    CartaModificadores().idProducto = int.parse(response.body);
   // print('Response status: ${response.statusCode}');

    return int.parse(response.body);
  }

  Future<String> saveImage (String nameFile, List<int> file) async{
    var url = Uri.parse(Config.hostbase+"productos/imagen");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromBytes('file', file,
        contentType: new MediaType('image', 'jpeg'),
        filename: nameFile));
    request.fields['texto'] = "Imagen guardada";

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
      else{
        print(response.statusCode);
      }
    });
  }

  Future<String> editProduct(Map<String,dynamic> productoNuevo) async {
    var url = Uri.parse(Config.hostbase+"productos");
    var response = await http.put(
        url,
        body: jsonEncode(productoNuevo),
        headers: {"Content-Type": "application/json"}
    );
    //print('Response status: ${response.statusCode}');
    return response.body;
  }
  Future<String> deleteProduct(int id) async {
    var url = Uri.parse(Config.hostbase+"productos?id="+id.toString());
    var response = await http.delete(url);
    //print (response.body);
    return response.body;
  }

  Future<List<Productojson>> readAllProduct() async{
    var url = Uri.parse(Config.hostbase+"productos");
    var response = await http.get(
        url,
        headers: {"Content-Type":"application/json"}
    );
   List <dynamic> listado = json.decode(response.body);
   List<Productojson> listadoProductos = listado.map((model)=> Productojson.fromJson(model)).toList();
   return listadoProductos;
  }
}