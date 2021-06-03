import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/providers/carta_providers.dart';

class DetallesProducto extends StatelessWidget {

  const DetallesProducto({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final modificador  = Provider.of<CartaModificadores>(context, listen: false);
    return Consumer<CartaModificadores>(
      builder: (_, modificador, __)=> Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Icon(Icons.restaurant_menu, size: 150)
                    //Image.asset('assets/tortilla.jpg', width: 150, height: 150),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                      onPressed: ()=>null,
                  child: Icon(Icons.camera_enhance_rounded),),
                  TextFormField(
                    controller: modificador.textEditingControllerProducto,
                    readOnly: modificador.bloquearFormulario,
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontStyle: FontStyle.normal),
                    decoration: InputDecoration(
                        labelText: "Producto:",
                        hintText: "Nombre del Producto",
                        border: InputBorder.none
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: modificador.textEditingControllerCategorias,
                    readOnly: modificador.bloquearFormulario,
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontStyle: FontStyle.normal),
                    decoration: InputDecoration(
                        labelText: "Categorias:",
                        hintText: "Categorias en las que puedo clasificar mi producto",
                        border: InputBorder.none
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller:modificador.textEditingControllerIngredientes,
                    readOnly:modificador.bloquearFormulario,
                    style: TextStyle(fontFamily: 'DancingScript', fontSize: 20),
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Ingredicentes:",
                      hintText: "Introducir ingredientes",
                      labelStyle: TextStyle(fontSize: 24, height: 0.7),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: modificador.textEditingControllerPrecio,
                    readOnly:modificador.bloquearFormulario,
                    style: TextStyle(fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.euro_symbol),
                      labelText: "Precio.",
                      hintText: "0.00",
                      border: InputBorder.none,
                      labelStyle: TextStyle( fontFamily: 'Montserrat', fontStyle: FontStyle.normal),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  // @override
  // void initState() {
  //   _controllerProducto = TextEditingController();
  // }
  //
  // @override
  // void dispose() {
  //   _controllerProducto.dispose();
  // }
}