
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'package:image_picker/image_picker.dart';





class DetallesProducto extends StatefulWidget {

  const DetallesProducto({Key key}) : super(key: key);

  @override
  _DetallesProductoState createState() => _DetallesProductoState();
}

class _DetallesProductoState extends State<DetallesProducto> {
  Image archivoImagen;
  List<int> _selectedFile;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final modificador  = Provider.of<CartaModificadores>(context, listen: false);
    return Consumer<CartaModificadores>(
      builder: (_, modificador, __)=> Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: Center(
                      child:   modificador.imagen
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    autovalidate: true,
                    child: FloatingActionButton(
                        onPressed: ()  {
                          seleccionarPicker();
                        },
                    child: Icon(Icons.camera_enhance_rounded),),
                  ),
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
                      labelText: "Ingredientes:",
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

  void seleccionarPicker()async{
    final modificador  = Provider.of<CartaModificadores>(context, listen: false);

    final picker =  await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if(kIsWeb){
        modificador.imagen = Image.network(picker.path);
      }else{
        //Todo
      }

    });
    modificador.selectedFile = await picker.readAsBytes();
    //Para android


  }

}