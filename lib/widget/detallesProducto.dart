import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/providers/carta_providers.dart';

class DetallesProducto extends StatefulWidget {

  const DetallesProducto({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetallesProductoState();

}

class DetallesProductoState extends State<DetallesProducto> {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 300,
                  width: 300,
                  child: Image.asset('assets/tortilla.jpg', width: 150, height: 150),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: <Widget>[
                TextFormField(
                  readOnly: context.watch<CartaModificadores>().bloquearFormulario,
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontStyle: FontStyle.normal),
                  initialValue: 'Tortilla de Patata',
                  decoration: InputDecoration(
                      labelText: "Producto:",
                      border: InputBorder.none
                  ),
                ),
                SizedBox(height: 5,),
                TextFormField(
                  readOnly:context.watch<CartaModificadores>().bloquearFormulario,
                  style: TextStyle(fontFamily: 'DancingScript', fontSize: 20),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  initialValue: "    " +
                      "Patatas, cebollas, huevos, aceite, sal",
                  decoration: InputDecoration(

                    labelText: "Ingredicentes:",
                    labelStyle: TextStyle(fontSize: 24, height: 0.7),
                    border: InputBorder.none,

                  ),
                ),
                SizedBox(height: 5,),
                TextFormField(
                  readOnly:context.watch<CartaModificadores>().bloquearFormulario,
                  style: TextStyle(fontFamily: 'Montserrat'),
                  initialValue: "5.50€",
                  decoration: InputDecoration(
                    labelText: "Precio.",
                    border: InputBorder.none,
                    labelStyle: TextStyle( fontFamily: 'Montserrat', fontStyle: FontStyle.normal),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}