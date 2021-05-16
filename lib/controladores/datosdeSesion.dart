import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class DatosdeSession extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: FlutterSession().get('myData'),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data['firstName'] + "|" + snapshot.data['secondName']
                : 'Loading...';
          });
  }
  
}