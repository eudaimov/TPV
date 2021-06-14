

import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/controladores/http/peticionesCarta.dart';
import 'package:tpv/modelo/productojson.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'package:tpv/vistas/carta/itemColumn.dart';

class AccionesPrincipales{

  PeticionesCarta mipeticioncarta = PeticionesCarta();

   static void enlazar(BuildContext context, String ruta) {
    Navigator.of(context).pushNamed(ruta);
  }


  Future<void> eliminar(BuildContext context) async{

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final modificador = Provider.of<CartaModificadores>(context, listen: false);
        return AlertDialog(
          title: const Text('¿Realmente desea eliminar?'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text("-   "+modificador.textEditingControllerProducto.text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('SI'),
              onPressed: () {

                if (modificador.idProducto != null) {
                  mipeticioncarta.deleteProduct(modificador.idProducto);
                  Productojson myProduct = Productojson(
                      id: modificador.idProducto,
                      producto: context
                          .read<CartaModificadores>()
                          .textEditingControllerProducto
                          .text,
                      ingrediente: context
                          .read<CartaModificadores>()
                          .textEditingControllerIngredientes
                          .text,
                      precio: double.parse(context
                          .read<CartaModificadores>()
                          .textEditingControllerPrecio
                          .text),
                      categorias: context
                          .read<CartaModificadores>()
                          .textEditingControllerCategorias
                          .text
                  );

                  modificador.milistadoProductos.removeAt(modificador.idItem);
                  modificador.myListKey.currentState.removeItem(modificador.idItem, (context, animation)=>
                      ItemListCartaRow(myProduct,modificador.idItem, animation ),

                  );


                  final snackBar = SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.thumb_up,
                          color: Colors.lightGreenAccent,
                        ),
                        Text("   Producto Eliminado")
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  modificador.resetFormulario();
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                //TODO
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  Future<void> guardar(BuildContext context){
    final modificador = Provider.of<CartaModificadores>(context, listen: false);
     if (modificador.idProducto == null) {

       Map<String, dynamic> productonuevo = {
         "producto": context
             .read<CartaModificadores>()
             .textEditingControllerProducto
             .text,
         "ingrediente": context
             .read<CartaModificadores>()
             .textEditingControllerIngredientes
             .text,
         "precio": context
             .read<CartaModificadores>()
             .textEditingControllerPrecio
             .text,
         "categorias": context
             .read<CartaModificadores>()
             .textEditingControllerCategorias
             .text,
       };
       if(modificador.imagen==null){
         productonuevo["rutaImagen"]="nula";
       }
       else{ productonuevo["rutaImagen"]="imagen";}


       mipeticioncarta.addProduct(productonuevo)
           .then((value){
         if(modificador.selectedFile!=null){
           String nombre = value.toString()+".jpeg";
           mipeticioncarta.saveImage(nombre, modificador.selectedFile);
           modificador.textEditingControllerRutaImagen.text = nombre;
           print(modificador.textEditingControllerRutaImagen.text);
         }
         Productojson myProduct = Productojson(
             id: value,
             producto: context
                 .read<CartaModificadores>()
                 .textEditingControllerProducto
                 .text,
             ingrediente: context
                 .read<CartaModificadores>()
                 .textEditingControllerIngredientes
                 .text,
             precio: double.parse(context
                 .read<CartaModificadores>()
                 .textEditingControllerPrecio
                 .text),
             categorias: context
                 .read<CartaModificadores>()
                 .textEditingControllerCategorias
                 .text,
             rutaImagen: context
                 .read<CartaModificadores>()
                 .textEditingControllerRutaImagen
                 .text
         );
         modificador.milistadoProductos.insert(0, myProduct);
         modificador.myListKey.currentState.insertItem(0);
         modificador.resetFormulario();
       }
       );
       final snackBar = SnackBar(
         content: Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[
             Icon(
               Icons.save,
               color: Colors.lightGreenAccent,
             ),
             Text("   Producto Guardado")
           ],
         ),
       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
     //Modificar producto
     else {

       //Existen tres casuisticas que  ya tenga imagen y se ha modificada, que sea la primera vez que se introduce una imagen, y que la imagen no hay sido modificada.

       if(modificador.selectedFile !=null && modificador.textEditingControllerRutaImagen.text!='nula'){
         print("Modificación");
         String palabras = modificador.textEditingControllerRutaImagen.text;
         int id = modificador.idProducto;
         //print(palabras);
         var regularExpresion = RegExp(r'_\d*_', caseSensitive: false, multiLine: false);
         if(regularExpresion.hasMatch(palabras)){
           final palabra = regularExpresion.firstMatch(palabras);
           String encontrada = palabra.group(0).toString();
           var limpieza = encontrada.split('_');
           int numero = int.parse(limpieza[1].toString()) + 1;
           String newNameFile =
               id.toString() + '_' + numero.toString() + '_.jpeg';
           modificador.textEditingControllerRutaImagen.text =
               newNameFile;
           mipeticioncarta.saveImage(
               newNameFile, modificador.selectedFile);
           //print(newNameFile);
         } else {
           String newNameFile = id.toString() + '_1_.jpeg';
           modificador.textEditingControllerRutaImagen.text =
               newNameFile;
           mipeticioncarta.saveImage(
               newNameFile, modificador.selectedFile);
           //print(newNameFile);
         }
       }else if(modificador.selectedFile !=null && modificador.textEditingControllerRutaImagen.text=='nula'){
         String nombre = modificador.idProducto.toString()+".jpeg";
         modificador.textEditingControllerRutaImagen.text = nombre;
         mipeticioncarta.saveImage(nombre, modificador.selectedFile);
       }else {
         print("Imagen no modificada");
       }
       Map<String, dynamic> productEdit = {
         "id": modificador.idProducto,
         "producto": context
             .read<CartaModificadores>()
             .textEditingControllerProducto
             .text,
         "ingrediente": context
             .read<CartaModificadores>()
             .textEditingControllerIngredientes
             .text,
         "precio": context
             .read<CartaModificadores>()
             .textEditingControllerPrecio
             .text,
         "categorias": context
             .read<CartaModificadores>()
             .textEditingControllerCategorias
             .text,
         "rutaImagen":context
             .read<CartaModificadores>()
             .textEditingControllerRutaImagen
             .text,
       };

       mipeticioncarta.editProduct(productEdit);

       Productojson myProduct = Productojson(
           id: modificador.idProducto,
           producto: context
               .read<CartaModificadores>()
               .textEditingControllerProducto
               .text,
           ingrediente: context
               .read<CartaModificadores>()
               .textEditingControllerIngredientes
               .text,
           precio: double.parse(context
               .read<CartaModificadores>()
               .textEditingControllerPrecio
               .text),
           categorias: context
               .read<CartaModificadores>()
               .textEditingControllerCategorias
               .text,
           rutaImagen: context
               .read<CartaModificadores>()
               .textEditingControllerRutaImagen
               .text
       );
       modificador.milistadoProductos.removeAt(modificador.idItem);
       modificador.myListKey.currentState.removeItem(modificador.idItem, (context, animation)=> ItemListCartaRow(myProduct,modificador.idItem, animation));
       modificador.milistadoProductos.insert(modificador.idItem, myProduct);
       modificador.myListKey.currentState.insertItem(modificador.idItem);
       modificador.resetFormulario();

       final snackBar = SnackBar(
         content: Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[
             Icon(
               Icons.thumb_up,
               color: Colors.lightGreenAccent,
             ),
             Text("   Producto Modificado")
           ],
         ),
       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
   }

}