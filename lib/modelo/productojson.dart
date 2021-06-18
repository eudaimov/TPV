
class Productojson {
  int _id;
  String _productName;
  String _ingredients;
  double _price;
  String _routeImage ;
  dynamic _categories;

  int get id => _id;
  String get productName => _productName;
  String get ingredients => _ingredients;
  String get routeImage => _routeImage;
  double get price => _price;
  dynamic get categories => _categories;

  Productojson({
      int id, 
      String productName, 
      String ingredients,
      String routeImage,
      double price, 
      dynamic categories}){
        _id = id;
        _productName = productName;
        _ingredients = ingredients;
        _routeImage = routeImage;
        _price = price;
        _categories = categories;
}

  Productojson.fromJson(dynamic json) {
    _id = json["id"];
    _productName = json["productName"];
    _ingredients = json["ingredients"];
    _routeImage = json["routeImage"];
    _price = json["price"];
    _categories = json["categories"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["productName"] = _productName;
    map["ingredients"] = _ingredients;
    map["routeImage"] = _routeImage;
    map["price"] = _price;
    map["categories"] = _categories;
    return map;
  }

}