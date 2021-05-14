import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemListCartaRow extends StatelessWidget{
  String textoItem;
  ItemListCartaRow(this.textoItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          //Alienacion vertical,
          children:<Widget>[
            Icon(Icons.restaurant_menu),
            Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(this.textoItem)))
          ]),
    );
  }

}