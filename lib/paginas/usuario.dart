
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpv/controladores/accionesPrincipales.dart';

class FichaUsuario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FichaUsuarioState();
}

class _FichaUsuarioState extends State<FichaUsuario> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  bool _mostraSecret = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TPV IN"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 350),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Nombre", prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Apellidos",
                    prefixIcon: Icon(Icons.person_outline)),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Numero de teléfono",
                    prefixIcon: Icon(Icons.phone)),
              ),
              TextFormField(
                controller: _date,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: "Fecha de Nacimiento",
                    prefixIcon: Icon(Icons.date_range)),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Correo electrónico",
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Direccion", prefixIcon: Icon(Icons.home_work)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Población:",
                    prefixIcon: Icon(Icons.map_outlined)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Provincia:", prefixIcon: Icon(Icons.map_sharp)),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Código Postal",
                    prefixIcon: Icon(Icons.gps_not_fixed)),
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                obscureText: _mostraSecret,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Contraseña:',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _mostraSecret = !_mostraSecret;
                      });
                    },
                    child: Icon(
                      _mostraSecret ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                obscureText: _mostraSecret,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Confirmar contraseña:',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _mostraSecret = !_mostraSecret;
                      });
                    },
                    child: Icon(
                      _mostraSecret ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock_outlined),
                ),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: ElevatedButton.icon(
                  onPressed: (){
                    AccionesPrincipales.enlazar(context, '/menuPrincipal');
                  },
                  label: Text('Registrarse'),
                  icon: Icon(Icons.app_registration),
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(
                            height: 1,
                            fontSize: 15)
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(text: formatter.format(picked));
      });
  }
}
