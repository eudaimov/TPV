import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpv/configuracion/configuraciones.dart';
import 'package:tpv/controladores/responsive.dart';
import 'package:tpv/modelo/productojson.dart';
import 'package:tpv/providers/carta_providers.dart';
import 'package:provider/provider.dart';
import 'package:tpv/vistas/carta/detallesProducto.dart';

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
          print(modificador.textEditingControllerRutaImagen.text);
          modificador.selectedFile =null;
          modificador.idItem = widget.idItem;
          modificador.idProducto = widget.miproducto.id;
          modificador.textEditingControllerProducto.text= widget.miproducto.productName;
          modificador.textEditingControllerIngredientes.text= widget.miproducto.ingredients;
          modificador.textEditingControllerCategorias.text = widget.miproducto.categories;
          modificador.textEditingControllerPrecio.text = widget.miproducto.price.toString();
          modificador.textEditingControllerRutaImagen.text = widget.miproducto.routeImage;
          modificador.imagen =  Image.network(Config.hostbase+"productos/imagen/"+widget.miproducto.routeImage);
          if(Responsive.isMobile(context)) {
            Navigator.push( context, MaterialPageRoute(builder: (context) =>
                Scaffold(
                    appBar: AppBar(),
                    body: DetallesProducto())));
          }
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
                              Text(this.widget.miproducto.productName),
                              Text(this.widget.miproducto.price.toString()+"€")
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