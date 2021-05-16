import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/providers/carta_providers.dart';

class ToolBar extends StatefulWidget{
  bool _mostrar;
  ToolBar(this._mostrar);
  @override
  State<StatefulWidget> createState()=> ToolBarState();
}

class ToolBarState extends State<ToolBar>{

  @override
  Widget build(BuildContext context) {


    return  AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: widget._mostrar? 60: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 2),
                ],),
              margin: EdgeInsets.all(5),
              height: 40,
              width: 40,
              child: Icon(Icons.fiber_new),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  context.read<CartaModificadores>().cambiarValor();
                });


                //TODO Problema no se como llamar al metodo hacerEditable de la clase DetallesProductoState
              },
              child: Container(
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 2),
                  ],),
                margin: EdgeInsets.all(5),
                height: 40,
                width: 40,
                child: Icon(Icons.edit_outlined),
              ),
            ),
            Container(
              decoration:
              BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 2),
                ],),
              margin: EdgeInsets.all(5),
              height: 40,
              width: 40,
              child: Icon(Icons.search_rounded),
            ),
            FloatingActionButton(
                onPressed: (){
                    null;
                },
                child: Icon(Icons.add_alert)
            )
          ],
        ),
      ),
    );
  }


}