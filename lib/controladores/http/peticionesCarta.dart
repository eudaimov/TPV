import 'dart:convert';
import 'package:tpv/configuracion/configuraciones.dart';
import 'package:http/http.dart' as http;
import 'package:tpv/modelo/productojson.dart';
import 'package:provider/provider.dart';
import 'package:tpv/providers/carta_providers.dart';

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
    print (response.body);
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