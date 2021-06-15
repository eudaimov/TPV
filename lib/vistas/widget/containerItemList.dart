import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemListCarta extends StatelessWidget{
  String textoItem;
  ItemListCarta(this.textoItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Wrap(
          spacing: 15,
          runAlignment: WrapAlignment.center,//Alineacion Horizontal
          direction: Axis.horizontal,//para la aliacion vertical
          alignment: WrapAlignment.start,//Alineacion Vertical,
          crossAxisAlignment: WrapCrossAlignment.center, //Alienacion entre hijos,
          children:<Widget>[
            Icon(Icons.person),
            Text(this.textoItem)
          ]),
    );
  }

}