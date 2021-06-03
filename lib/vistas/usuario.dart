
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpv/configuracion/configuraciones.dart';
import 'package:tpv/controladores/accionesPrincipales.dart';
import 'package:tpv/controladores/http/peticionesUsuario.dart';

class FichaUsuario extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FichaUsuarioState();
}

class _FichaUsuarioState extends State<FichaUsuario> {

  TextEditingController _controllerNombre = new TextEditingController();
  TextEditingController _controllerApellidos = new TextEditingController();
  TextEditingController _controllerNumeroTelefono = new TextEditingController();
  TextEditingController _controllerDateBirth = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  TextEditingController _controllerDireccion = new TextEditingController();
  TextEditingController _controllerPoblacion = new TextEditingController();
  TextEditingController _controllerProvincia = new TextEditingController();
  TextEditingController _controllerCodigoPostal = new TextEditingController();


  DateTime selectedDate = DateTime.now();
  bool _mostraSecret = false;


  @override
  Widget build(BuildContext context) {
    tag: "UsuarioLogin";
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
                controller: _controllerNombre,
                decoration: InputDecoration(
                    labelText: "Nombre", prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                controller: _controllerApellidos,
                decoration: InputDecoration(
                    labelText: "Apellidos",
                    prefixIcon: Icon(Icons.person_outline)),
              ),
              TextFormField(
                controller: _controllerNumeroTelefono,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Numero de teléfono",
                    prefixIcon: Icon(Icons.phone)),
              ),
              TextFormField(
                controller: _controllerDateBirth,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: "Fecha de Nacimiento",
                    prefixIcon: Icon(Icons.date_range)),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Correo electrónico",
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              TextFormField(
                controller: _controllerDireccion,
                decoration: InputDecoration(
                    labelText: "Direccion", prefixIcon: Icon(Icons.home_work)),
              ),
              TextFormField(
                controller: _controllerPoblacion,
                decoration: InputDecoration(
                    labelText: "Población:",
                    prefixIcon: Icon(Icons.map_outlined)),
              ),
              TextFormField(
                controller: _controllerProvincia,
                decoration: InputDecoration(
                    labelText: "Provincia:", prefixIcon: Icon(Icons.map_sharp)),
              ),
              TextFormField(
                controller: _controllerCodigoPostal,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Código Postal",
                    prefixIcon: Icon(Icons.gps_not_fixed)),
              ),
              TextFormField(
                controller: _controllerPassword,
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
                    String url = Config.hostbase+"usuario/add";
                    Map<String, String > usuario = {
                      "nick": "${_controllerNombre.text}",
                      "nombre": "${_controllerNombre.text}",
                      "apellidos": "${_controllerApellidos.text}",
                      "password": "${_controllerPassword.text}",
                      "fechaNacimiento": "${_controllerDateBirth.text}",
                      "direccion": "${_controllerDireccion.text}",
                      "poblacion": "${_controllerPoblacion.text}",
                      "provincia": "${_controllerProvincia.text}",
                      "codigoPostal": "${_controllerCodigoPostal.text}",
                      "numeroTelefono": "${_controllerNumeroTelefono.text}",
                      "email": "${_controllerEmail.text}"
                    };
                    Peticiones mipeticion = Peticiones(url);
                    mipeticion.addUser(usuario);

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
        _controllerDateBirth.value = TextEditingValue(text: formatter.format(picked));
      });
  }
}
