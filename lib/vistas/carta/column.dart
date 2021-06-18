import 'package:flutter/material.dart';
import 'package:tpv/controladores/http/peticionesCarta.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'package:provider/provider.dart';

import 'itemColumn.dart';

class ColumnElements extends StatefulWidget {
  
  @override
  _ColumnElementsState createState() => _ColumnElementsState();
}

class _ColumnElementsState extends State<ColumnElements> {

  @override
  Widget build(BuildContext context) {
    final modificador = Provider.of<CartaModificadores>(context, listen: false);
    ScrollController controllerScroll = ScrollController(initialScrollOffset: 0);

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[100]),
      // alignment: Alignment.topCenter,
      child: Scrollbar(
        isAlwaysShown: false,
        controller: controllerScroll,
        child: FutureBuilder(
            future: PeticionesCarta().readAllProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                modificador.miListadoProductos = snapshot.data;
                modificador.miListadoProductosScreen = modificador.miListadoProductos;


                return Consumer<CartaModificadores>(
                  builder: (_, modificador, __)=>AnimatedList(
                    padding: EdgeInsets.only(top:10, bottom: 10),
                    key: modificador.myListKey,
                    initialItemCount: modificador.miListadoProductosScreen.length,
                    itemBuilder: (context, index, animation){
                      return ItemListCartaRow(modificador.miListadoProductosScreen[index], index, animation);
                    },
                    controller: controllerScroll,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                );
              } else if(snapshot.hasError){
                modificador.miListadoProductosScreen = [];
                modificador.miListadoProductos = [];
                return Consumer<CartaModificadores>(
                  builder: (_, modificador, __)=>AnimatedList(
                    padding: EdgeInsets.only(top:10, bottom: 10),
                    key: modificador.myListKey,
                    initialItemCount: modificador.miListadoProductosScreen.length, //modificador.miListadoProductosfilter.length,
                    itemBuilder: (context, index, animation){
                      return ItemListCartaRow(modificador.miListadoProductosScreen[index], index, animation);
                    },
                    controller: controllerScroll,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  ),
                );
              }else{
                return Container(
                  child: Center(
                    child: CircularProgressIndicator()
                  ),
                );
              }
            }),
      ),
    );
  }


}
