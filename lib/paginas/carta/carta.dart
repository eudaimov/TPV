import 'package:flutter/material.dart';
import 'package:tpv/paginas/carta/columnElements.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'detallesProducto.dart';
import 'toolBar.dart';
import 'itemColumn.dart';
import 'package:provider/provider.dart';



class Carta extends StatelessWidget {

  bool editarCarta = true;

  @override
  Widget build(BuildContext context) {
    final modificador  = Provider.of<CartaModificadores>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("La Carta"),
        centerTitle: true,
        shadowColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "botonMostrar",
        onPressed: () {
          modificador.mostrarOcultarBarra();
            },
        child: Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
          children:<Widget>[
            Consumer<CartaModificadores>(
                builder: (_, modificador, __)=> ToolBar(context.read<CartaModificadores>().mostrarBarradeHerramientasPrincipal)),
            Expanded(
              flex: 1,
              child: Row(
                  children:<Widget>[
                    ColumnElements(),
                    Expanded(
                        flex: 4,
                        child: DetallesProducto()
                    )
                  ]
              ),
            ),
          ]
      ),



    );
  }
}
