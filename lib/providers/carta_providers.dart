import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tpv/modelo/productojson.dart';

class CartaModificadores with ChangeNotifier {

  bool _motrarBarradeHerramientasPrincipal = false;
  bool _bloquearFormulario = false;
  int _idProducto;
  int _idItem;
  TextEditingController _textEditingControllerProducto =  TextEditingController();
  TextEditingController _textEditingControllerIngredientes =  TextEditingController();
  TextEditingController _textEditingControllerCategorias =  TextEditingController();
  TextEditingController _textEditingControllerPrecio =  TextEditingController();
  TextEditingController _textEditingControllerRutaImagen = TextEditingController();
  Image _imagen;
  List<int> _selectedFile;
  GlobalKey<AnimatedListState> _myListKey = GlobalKey<AnimatedListState>();
  List<Productojson> _miListadoProductos;


  bool get bloquearFormulario => _bloquearFormulario;
  bool get mostrarBarradeHerramientasPrincipal => _motrarBarradeHerramientasPrincipal;
  int get idProducto => _idProducto;
  int get idItem => _idItem;
  TextEditingController get textEditingControllerProducto => _textEditingControllerProducto;
  TextEditingController get textEditingControllerIngredientes =>  _textEditingControllerIngredientes;
  TextEditingController get textEditingControllerCategorias => _textEditingControllerCategorias;
  TextEditingController get textEditingControllerPrecio => _textEditingControllerPrecio;
  TextEditingController get textEditingControllerRutaImagen => _textEditingControllerRutaImagen;
  Image get imagen => _imagen;
  List<int> get selectedFile =>_selectedFile;
  get myListKey => _myListKey;
  List<Productojson> get milistadoProductos => _miListadoProductos;

  set imagen(Image image){
    _imagen = image;
    notifyListeners();
  }
  set selectedFile(List<int> arraybytes){
    _selectedFile = arraybytes;
  }

  set bloquearFormulario(bool value) {
    _bloquearFormulario = value;
  }

  set idProducto(int value) {
    _idProducto = value;
  }
  set idItem(int value){
    _idItem = value;
  }
  set milistadoProductos(List<Productojson> value) {
    _miListadoProductos = value;
  }


  void mostrarOcultarBarra(){
    _motrarBarradeHerramientasPrincipal =! _motrarBarradeHerramientasPrincipal;
    notifyListeners();
  }
  void cambiarValor(){
        _bloquearFormulario = !_bloquearFormulario;
        notifyListeners();
  }
  void resetFormulario(){
    _idProducto = null;
    _textEditingControllerProducto.text='';
     _textEditingControllerIngredientes.text='';
     _textEditingControllerCategorias.text='';
     _textEditingControllerPrecio.text='';
    _textEditingControllerRutaImagen.text='';
    _imagen = null;
     notifyListeners();
  }


}