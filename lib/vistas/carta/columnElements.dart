import 'package:flutter/material.dart';
import 'package:tpv/controladores/http/peticionesCarta.dart';
import 'package:tpv/modelo/productojson.dart';
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
    ScrollController controllerScroll = ScrollController();

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
                List<Productojson> milistado = snapshot.data;
                modificador.milistadoProductos = milistado;

                return AnimatedList(
                  padding: EdgeInsets.only(top:10, bottom: 10),
                  key: modificador.myListKey,
                  initialItemCount: modificador.milistadoProductos.length,
                  itemBuilder: (context, index, animation){
                    return ItemListCartaRow(modificador.milistadoProductos[index], index, animation);
                  },
                  controller: controllerScroll,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                );
              } else if(snapshot.hasError){
                  return Container(
                    child: Center(
                      child: Text("No se ha encontrado Datos"),
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
