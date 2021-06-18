import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tpv/controladores/http/peticionesCarta.dart';
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
  TextEditingController _textEditingControllerBusqueda = TextEditingController();
  Image _imagen;
  List<int> _selectedFile;

  List<Productojson> _miListadoProductos;
  List<Productojson> _miListadoProductosScreen;
  GlobalKey<AnimatedListState> _myListKey = GlobalKey<AnimatedListState>();
  int cantidaditem = 0;



  bool get bloquearFormulario => _bloquearFormulario;
  bool get mostrarBarradeHerramientasPrincipal => _motrarBarradeHerramientasPrincipal;
  int get idProducto => _idProducto;
  int get idItem => _idItem;
  TextEditingController get textEditingControllerProducto => _textEditingControllerProducto;
  TextEditingController get textEditingControllerIngredientes =>  _textEditingControllerIngredientes;
  TextEditingController get textEditingControllerCategorias => _textEditingControllerCategorias;
  TextEditingController get textEditingControllerPrecio => _textEditingControllerPrecio;
  TextEditingController get textEditingControllerRutaImagen => _textEditingControllerRutaImagen;
  TextEditingController get textEditingControllerBusqueda => _textEditingControllerBusqueda;
  Image get imagen => _imagen;
  List<int> get selectedFile =>_selectedFile;
  List<Productojson> get miListadoProductos => _miListadoProductos;
  List<Productojson> get miListadoProductosScreen => _miListadoProductosScreen;
  GlobalKey<AnimatedListState> get myListKey => _myListKey;




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
  set miListadoProductos(List<Productojson> value) {
    _miListadoProductos = value;
  }
  set miListadoProductosScreen(List<Productojson> value) {
    _miListadoProductosScreen = value;
  }


  void changeListProduct(String name) {
    int cantidadAntigua= miListadoProductosScreen.length;
    int cantidadNuevaBusqueda= _miListadoProductos.where((element) => element.productName.contains(name)).toList().length;

    if(cantidadAntigua>cantidadNuevaBusqueda) {
      int cantidadEliminar = cantidadAntigua - cantidadNuevaBusqueda;
      for (var i = 0; i < cantidadEliminar; i++) {
        _myListKey.currentState.removeItem(0,
                (BuildContext context, Animation<double> animation) {
              return Container();
            });
      }
    }
    if(cantidadAntigua<cantidadNuevaBusqueda) {
      int cantidadinsertar = cantidadNuevaBusqueda - cantidadAntigua;
      for (var i = 0; i < cantidadinsertar; i++) {
        _myListKey.currentState.insertItem(0);
      }
    }
    miListadoProductosScreen = _miListadoProductos.where((element) => element.productName.contains(name)).toList();

    notifyListeners();
  }
  void changeListProductreset() {
    int cantidadAntigua= miListadoProductosScreen.length;
    int cantidadNuevaBusqueda= miListadoProductos.length;

    if(cantidadAntigua>cantidadNuevaBusqueda) {
      int cantidadEliminar = cantidadAntigua - cantidadNuevaBusqueda;
      for (var i = 0; i < cantidadEliminar; i++) {
        _myListKey.currentState.removeItem(0,
                (BuildContext context, Animation<double> animation) {
              return Container();
            });
      }
    }
    if(cantidadAntigua<cantidadNuevaBusqueda) {
      int cantidadinsertar = cantidadNuevaBusqueda - cantidadAntigua;
      for (var i = 0; i < cantidadinsertar; i++) {
        _myListKey.currentState.insertItem(0);
      }
    }
    miListadoProductosScreen = miListadoProductos;
    textEditingControllerBusqueda.text = '';

    notifyListeners();
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
    _idItem = null;
    _selectedFile = null;
     notifyListeners();
  }




}