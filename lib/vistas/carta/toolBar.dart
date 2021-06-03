import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/controladores/http/peticionesCarta.dart';
import 'package:tpv/modelo/productojson.dart';
import 'package:tpv/providers/carta_providers.dart';

import 'itemColumn.dart';

class ToolBar extends StatelessWidget {
  bool _mostrar;

  ToolBar(this._mostrar);

  Color colorEditar = Colors.blue;

  @override
  Widget build(BuildContext context) {
    PeticionesCarta mipeticioncarta = new PeticionesCarta();
    final modificador = Provider.of<CartaModificadores>(context, listen: false);
    Animation animation;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: _mostrar ? 60 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            //Button to create new product
            FloatingActionButton(
              heroTag: "BotonNuevo",
              hoverColor: Colors.blue[700],
              onPressed: () {
                modificador.idProducto = null;
                context
                    .read<CartaModificadores>()
                    .textEditingControllerProducto
                    .text = '';
                context
                    .read<CartaModificadores>()
                    .textEditingControllerIngredientes
                    .text = '';
                context
                    .read<CartaModificadores>()
                    .textEditingControllerPrecio
                    .text = '';
                context
                    .read<CartaModificadores>()
                    .textEditingControllerCategorias
                    .text = '';
              },
              child: Icon(Icons.fiber_new_rounded),
            ),
            //Button to save product
            Consumer<CartaModificadores>(
              builder: (context, modificador, child) => FloatingActionButton(
                heroTag: "BotonGuardar",
                hoverColor: Colors.blue[700],
                onPressed: () {
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
                          .text
                    };
                    mipeticioncarta.addProduct(productonuevo)
                        .then((value){
                          print(value);
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
                          .text
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
                },
                child: Icon(Icons.save),
              ),
            ),
            Consumer<CartaModificadores>(
              builder: (_, modificador, __) => FloatingActionButton(
                heroTag: "BotonEditar",
                hoverColor: modificador.bloquearFormulario
                    ? Colors.grey[700]
                    : Colors.blue[700],
                backgroundColor:
                    modificador.bloquearFormulario ? Colors.grey : Colors.blue,
                onPressed: () {
                  context.read<CartaModificadores>().cambiarValor();
                },
                child: Icon(Icons.edit),
              ),
            ),
            FloatingActionButton(
              heroTag: "BotonBuscar",
              hoverColor: Colors.blue[700],
              onPressed: () {

                print(modificador.idItem);
                print(modificador.milistadoProductos[modificador.idItem].producto);
              },
              child: Icon(Icons.search_rounded),
            ),
            FloatingActionButton(
              heroTag: "Eliminar",

              onPressed: () {
                print(modificador.idProducto);
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
                ;
              },
              hoverColor: Colors.blue[700],
              child: Icon(Icons.delete_outline),
            )
          ],
        ),
      ),
    );
  }
}
