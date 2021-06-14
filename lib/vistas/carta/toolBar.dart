import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/controladores/accionesPrincipales.dart';
import 'package:tpv/controladores/http/peticionesCarta.dart';
import 'package:tpv/controladores/responsive.dart';
import 'package:tpv/modelo/productojson.dart';
import 'package:tpv/providers/carta_providers.dart';

import 'itemColumn.dart';

class ToolBar extends StatefulWidget {
  bool _mostrar;

  ToolBar(this._mostrar);

  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  Color colorEditar = Colors.blue;
  AccionesPrincipales miaccion = AccionesPrincipales();

  @override
  Widget build(BuildContext context) {

    final modificador = Provider.of<CartaModificadores>(context, listen: false);
    Animation animation;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget._mostrar ? 60 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            //Button to create new product
            Consumer<CartaModificadores>(
              builder: (context, modificador, child) => FloatingActionButton(
                heroTag: "BotonNuevo",
                hoverColor: Colors.blue[700],
                onPressed: () {
                  modificador.idProducto = null;
                  context.read<CartaModificadores>().imagen = null;
                  if(modificador.imagen != null){
                    print("Tiene contenido");
                  }else{
                    print("No Tiene contenido");
                  }
                  modificador.resetFormulario();
                },
                child: Icon(Icons.fiber_new_rounded),
              ),
            ),
            //Button to save product
            Consumer<CartaModificadores>(
              builder: (context, modificador, child) => FloatingActionButton(
                heroTag: "BotonGuardar",
                hoverColor: Colors.blue[700],
                onPressed: () {
                  miaccion.guardar(context);
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
                  modificador.cambiarValor();
                },
                child: Icon(Icons.edit),
              ),
            ),
            FloatingActionButton(
              heroTag: "Eliminar",
              onPressed: () {
                miaccion.eliminar(context);
              },
              hoverColor: Colors.blue[700],
              child: Icon(Icons.delete_outline),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: Responsive.isMobile(context)?  10:80, left: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Producto a buscar",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue[100]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),


                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}