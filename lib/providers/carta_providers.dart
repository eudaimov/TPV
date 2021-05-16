import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartaModificadores with ChangeNotifier, DiagnosticableTreeMixin {
  bool _bloquearFormulario = false;

  get bloquearFormulario{
    return _bloquearFormulario;
  }
  void cambiarValor(){
        _bloquearFormulario = !_bloquearFormulario;
        notifyListeners();
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('bloquear', bloquearFormulario));
  }

}