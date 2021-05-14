
import 'package:flutter/material.dart';
import 'package:tpv/controladores/accionesPrincipales.dart';

class Contenedor extends StatelessWidget {
  String _texto;
  IconData miicono;
  String _ruta;

  Contenedor(this._texto, this.miicono, this._ruta);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> AccionesPrincipales.enlazar(context, this._ruta),
      child: Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 15),
          ],
        ),
        child: Center(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              Text(
                _texto,
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(miicono)
            ]))),
      ),
    );
  }
}
