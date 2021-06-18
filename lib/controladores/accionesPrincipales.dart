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
    final modificador = Provider.of<CartaModificadores>(context, listen: false);
    modificador.changeListProductreset();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                      productName: context
                          .read<CartaModificadores>()
                          .textEditingControllerProducto
                          .text,
                      ingredients: context
                          .read<CartaModificadores>()
                          .textEditingControllerIngredientes
                          .text,
                      price: double.parse(context
                          .read<CartaModificadores>()
                          .textEditingControllerPrecio
                          .text),
                      categories: context
                          .read<CartaModificadores>()
                          .textEditingControllerCategorias
                          .text
                  );


                  print(modificador.miListadoProductos.length);
                  int idlist = modificador.miListadoProductos.indexWhere((element) => element.id==modificador.idProducto);
                  modificador.miListadoProductos.removeAt(idlist);



                  modificador.myListKey.currentState.removeItem(modificador.idItem, (context, animation)=>
                      ItemListCartaRow(myProduct, modificador.idItem, animation ),
                  );




                  final snackBar = SnackBar(
                    duration: Duration(milliseconds: 300),
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
    if(validacionesNumero(modificador.textEditingControllerPrecio.text) && validacionesTextoCompleto(
        modificador.textEditingControllerProducto.text, modificador.textEditingControllerCategorias.text,
        modificador.textEditingControllerIngredientes.text, modificador.textEditingControllerPrecio.text)) {
      modificador.changeListProductreset();
      if (modificador.idProducto == null) {
        Map<String, dynamic> productonuevo = {
          "productName": context
              .read<CartaModificadores>()
              .textEditingControllerProducto
              .text,
          "ingredients": context
              .read<CartaModificadores>()
              .textEditingControllerIngredientes
              .text,
          "price": context
              .read<CartaModificadores>()
              .textEditingControllerPrecio
              .text,
          "categories": context
              .read<CartaModificadores>()
              .textEditingControllerCategorias
              .text,
        };
        if (modificador.selectedFile == null) {
          productonuevo["routeImage"] = "nulo.jpeg";
        }
        else {
          productonuevo["routeImage"] = "imagen";
        }
        String nombre = 'nulo.jpeg';
        print(productonuevo["routeImage"]);
        mipeticioncarta.addProduct(productonuevo)
            .then((value) {
          if (modificador.selectedFile != null) {
            nombre = value.toString() + ".jpeg";
            mipeticioncarta.saveImage(nombre, modificador.selectedFile);
            modificador.textEditingControllerRutaImagen.text = nombre;
            print(modificador.textEditingControllerRutaImagen.text);
          }
          Productojson myProduct = Productojson(
              id: value,
              productName: context
                  .read<CartaModificadores>()
                  .textEditingControllerProducto
                  .text,
              ingredients: context
                  .read<CartaModificadores>()
                  .textEditingControllerIngredientes
                  .text,
              price: double.parse(context
                  .read<CartaModificadores>()
                  .textEditingControllerPrecio
                  .text),
              categories: context
                  .read<CartaModificadores>()
                  .textEditingControllerCategorias
                  .text,
              routeImage: nombre
          );
          modificador.miListadoProductosScreen.insert(
              modificador.miListadoProductosScreen.length, myProduct);
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
        //Existen tres casuisticas:
        // que  ya tenga imagen y se ha modificada,
        // que sea la primera vez que se introduce una imagen, y
        // que la imagen no hay sido modificada.

        if (modificador.selectedFile != null &&
            modificador.textEditingControllerRutaImagen.text != 'nulo.jpeg') {
          String palabras = modificador.textEditingControllerRutaImagen.text;
          int id = modificador.idProducto;
          print("----------" + palabras);
          var regularExpresion = RegExp(
              r'_\d*_', caseSensitive: false, multiLine: false);
          if (regularExpresion.hasMatch(palabras)) {
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
          } else {
            String newNameFile = id.toString() + '_1_.jpeg';
            modificador.textEditingControllerRutaImagen.text =
                newNameFile;
            mipeticioncarta.saveImage(
                newNameFile, modificador.selectedFile);
          }
        } else if (modificador.selectedFile != null &&
            modificador.textEditingControllerRutaImagen.text == 'nulo.jpeg') {
          String nombre = modificador.idProducto.toString() + ".jpeg";
          modificador.textEditingControllerRutaImagen.text = nombre;
          mipeticioncarta.saveImage(nombre, modificador.selectedFile);
        } else {
          print("Imagen no modificada");
        }
        Map<String, dynamic> productEdit = {
          "id": modificador.idProducto,
          "productName": context
              .read<CartaModificadores>()
              .textEditingControllerProducto
              .text,
          "ingredients": context
              .read<CartaModificadores>()
              .textEditingControllerIngredientes
              .text,
          "price": context
              .read<CartaModificadores>()
              .textEditingControllerPrecio
              .text,
          "categories": context
              .read<CartaModificadores>()
              .textEditingControllerCategorias
              .text,
          "routeImage": context
              .read<CartaModificadores>()
              .textEditingControllerRutaImagen
              .text,
        };

        mipeticioncarta.editProduct(productEdit);

        Productojson myProduct = Productojson(
            id: modificador.idProducto,
            productName: context
                .read<CartaModificadores>()
                .textEditingControllerProducto
                .text,
            ingredients: context
                .read<CartaModificadores>()
                .textEditingControllerIngredientes
                .text,
            price: double.parse(context
                .read<CartaModificadores>()
                .textEditingControllerPrecio
                .text),
            categories: context
                .read<CartaModificadores>()
                .textEditingControllerCategorias
                .text,
            routeImage: context
                .read<CartaModificadores>()
                .textEditingControllerRutaImagen
                .text
        );

        int idlist = modificador.miListadoProductosScreen.indexWhere((
            element) => element.id == modificador.idProducto);
        modificador.miListadoProductosScreen.removeAt(idlist);
        modificador.miListadoProductosScreen.insert(idlist, myProduct);

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
    }else{
      final snackBar = SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.save,
              color: Colors.red,
            ),
            Text("   F. incompleto o precio incorrecto.")
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
   }

  bool validacionesNumero(String numberParam){
    if(double.tryParse(numberParam)!=null)
      return true;
    else
      return false;
   }

  bool validacionesTextoCompleto(String producto, String categoria, String ingredientes, String precio){

     if( producto.isNotEmpty && categoria.isNotEmpty && ingredientes.isNotEmpty && precio.isNotEmpty){
       return true;
     }
     return false;
  }

}