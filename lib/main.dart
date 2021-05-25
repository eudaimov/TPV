import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tpv/paginas/routes.dart';
import 'package:provider/provider.dart';
import 'package:tpv/providers/carta_providers.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) =>CartaModificadores(),
          )
        ],
        child: Routes()
      )
    );
}

