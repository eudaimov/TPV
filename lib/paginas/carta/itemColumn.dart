import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpv/modelo/productojson.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'package:provider/provider.dart';

class ItemListCartaRow extends StatefulWidget{
  Productojson miproducto;
  int idItem;
  Animation animation;
  ItemListCartaRow(this.miproducto, this.idItem, this.animation);

  @override
  _ItemListCartaRowState createState() => _ItemListCartaRowState();
}

class _ItemListCartaRowState extends State<ItemListCartaRow> {
  @override
  Widget build(BuildContext context) {

    final modificador  = Provider.of<CartaModificadores>(context, listen: false);


    return SizeTransition(

      sizeFactor: widget.animation,
      child: GestureDetector(

        onTap: (){
          modificador.idItem = widget.idItem;
          modificador.idProducto = widget.miproducto.id;
          modificador.textEditingControllerProducto.text= widget.miproducto.producto;
          modificador.textEditingControllerIngredientes.text= widget.miproducto.ingrediente;
          modificador.textEditingControllerCategorias.text = widget.miproducto.categorias;
          modificador.textEditingControllerPrecio.text = widget.miproducto.precio.toString();

        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
              //Alienacion vertical,
              children:<Widget>[
                Icon(Icons.restaurant_menu),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            children:<Widget>[
                              Text(this.widget.miproducto.producto),
                              Text(this.widget.miproducto.precio.toString()+"€")
                            ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        )
                    ))
              ]),
        ),
      ),
    );
  }
}