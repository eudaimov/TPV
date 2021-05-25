
class Productojson {
  int _id;
  String _producto;
  String _ingrediente;
  double _precio;
  dynamic _categorias;

  int get id => _id;
  String get producto => _producto;
  String get ingrediente => _ingrediente;
  double get precio => _precio;
  dynamic get categorias => _categorias;

  Productojson({
      int id, 
      String producto, 
      String ingrediente, 
      double precio, 
      dynamic categorias}){
    _id = id;
    _producto = producto;
    _ingrediente = ingrediente;
    _precio = precio;
    _categorias = categorias;
}

  Productojson.fromJson(dynamic json) {
    _id = json["id"];
    _producto = json["producto"];
    _ingrediente = json["ingrediente"];
    _precio = json["precio"];
    _categorias = json["categorias"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["producto"] = _producto;
    map["ingrediente"] = _ingrediente;
    map["precio"] = _precio;
    map["categorias"] = _categorias;
    return map;
  }

}