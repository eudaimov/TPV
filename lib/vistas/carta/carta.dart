import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tpv/controladores/responsive.dart';
import 'package:tpv/providers/carta_providers.dart';

import 'columnElements.dart';
import 'detallesProducto.dart';
import 'toolBar.dart';



class Carta extends StatelessWidget {

  bool editarCarta = true;

  @override
  Widget build(BuildContext context) {
    Size _dimension = MediaQuery.of(context).size;
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
      body: Responsive(
        desktop:
        Column(children: <Widget>[
          Consumer<CartaModificadores>(
              builder: (_, modificador, __) => ToolBar(context
                  .read<CartaModificadores>()
                  .mostrarBarradeHerramientasPrincipal)),
          Expanded(
            child: Container(
              color: Colors.yellowAccent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            color: Colors.grey,
                            child: ColumnElements()
                        )
                    ),
                    Expanded(
                      flex: 5,
                      child: DetallesProducto(),
                    )
                  ]),
            ),
          ),
        ]),
        tablet:         Column(children: <Widget>[
          Consumer<CartaModificadores>(
              builder: (_, modificador, __) => ToolBar(context
                  .read<CartaModificadores>()
                  .mostrarBarradeHerramientasPrincipal)),
          Expanded(
            child: Container(
              color: Colors.yellowAccent,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            color: Colors.grey,
                            child: ColumnElements()
                        )
                    ),
                    Expanded(
                      flex: 6,
                      child: DetallesProducto(),
                    )
                  ]),
            ),
          ),
        ]),
        mobile: Column(children: <Widget>[
          Consumer<CartaModificadores>(
              builder: (_, modificador, __) => ToolBar(context
                  .read<CartaModificadores>()
                  .mostrarBarradeHerramientasPrincipal)),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: Colors.grey,
              child: ColumnElements(),
            )
          )
        ]),
      ),
    );
  }
}
