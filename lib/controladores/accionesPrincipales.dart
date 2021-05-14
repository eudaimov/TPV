import 'package:flutter/material.dart';

class AccionesPrincipales{

   static void enlazar(BuildContext context, String ruta) {
    Navigator.of(context).pushNamed(ruta);
  }

}