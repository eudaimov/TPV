import 'package:flutter/material.dart';

class EdicionFormulario extends InheritedWidget{
  final Widget child;
  final bool editable;

  EdicionFormulario({
    Key key,
    this.child,
    this.editable,
  }) : super(key: key, child: child );

  static EdicionFormulario of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<EdicionFormulario>();
  }

  @override
  bool updateShouldNotify(EdicionFormulario oldWidget) {
    return true;
  }


}