import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpv/controladores/editarformulario.dart';
import 'package:tpv/widget/containerItemListRow.dart';
import 'package:tpv/widget/detallesProducto.dart';
import 'package:tpv/widget/toolBar.dart';

class Carta extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> CartaState();

}
class CartaState extends State<Carta>{
  ScrollController controllerScroll = ScrollController();
  bool _mostrar;
  bool editarCarta = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("La Carta"),
        centerTitle: true,
        shadowColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            this.showToolBar();
            },
        child: Icon(Icons.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: EdicionFormulario(
        editable: editarCarta,
        child: Column(
            children:<Widget>[
              ToolBar(_mostrar),
              Expanded(
                flex: 1,
                child: Row(
                    children:<Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  right:BorderSide(
                                      width: 2
                                  )
                              )
                          ),
                          alignment: Alignment.topCenter,
                          child: Scrollbar(
                            isAlwaysShown: false ,
                            controller: controllerScroll,
                            child: ListView(
                              controller: controllerScroll,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                ItemListCartaRow("CocaCola"),
                                Divider(),
                                ItemListCartaRow("Fanta Naranja"),
                                Divider(),
                                ItemListCartaRow("Tortilla de Patatas"),
                                Divider(),
                                ItemListCartaRow("Calamares a la Romana"),
                                Divider(),
                                ItemListCartaRow("Coca Cola"),
                                Divider(),
                                ItemListCartaRow("Fanta Naranja"),
                                Divider(),
                                ItemListCartaRow("Tortilla de Patatas"),
                                Divider(),
                                ItemListCartaRow("Calamares a la Romana"),
                                Divider(),
                                ItemListCartaRow("Coca Cola"),
                                Divider(),
                                ItemListCartaRow("Fanta Naranja"),
                                Divider(),
                                ItemListCartaRow("Tortilla de Patatas"),
                                Divider(),
                                ItemListCartaRow("Calamares a la Romana"),
                                Divider(),
                                ItemListCartaRow("Coca Cola"),
                                Divider(),
                                ItemListCartaRow("Fanta Naranja"),
                                Divider(),
                                ItemListCartaRow("Tortilla de Patatas"),
                                Divider(),
                                ItemListCartaRow("Calamares a la Romana"),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: DetallesProducto()
                      )
                    ]
                ),
              ),
            ]
        ),
      ),



    );
  }

  @override
  void initState() {
   _mostrar=false;

  }

  void showToolBar(){
    setState(() {
      _mostrar = !_mostrar;
    });
  }



}
