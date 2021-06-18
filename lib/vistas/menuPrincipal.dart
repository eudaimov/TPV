
import 'package:flutter/material.dart';
import 'package:tpv/vistas/widget/containerPrueba.dart';


class MenuPrincipal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu principal"),
        leading: Container(),
      ),
      body: Center(
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[ Center(
              child: Wrap(
                children:<Widget>[
                  Contenedor('Carta', Icons.collections_bookmark_rounded, '/carta'),
                  Contenedor('Usuario', Icons.person, '/formularioUsuario'),
                  Contenedor('Restaurante', Icons.home_filled, '/menuPrincipal'),
                  Contenedor('Areas de Trabajo',Icons.workspaces_outline, '/menuPrincipal'),

                ]
          ),
            )
        ]
          ),
      )
    );
  }

}
