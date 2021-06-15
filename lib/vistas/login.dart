//import 'dart:html';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpv/configuracion/configuraciones.dart';
import 'package:tpv/controladores/accionesPrincipales.dart';
import 'package:tpv/controladores/createSession.dart';
import 'package:tpv/controladores/http/peticionesUsuario.dart';
import 'package:tpv/modelo/usuarioSesion.dart';
import 'package:tpv/vistas/widget/inputFieldCustom.dart';


class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final estilo = TextStyle(fontSize: 18, color: Colors.lightBlue, height: 1);

  bool mover = false;
  double position = -10;

  @override
  Widget build(BuildContext context) {
    final controladorNombre = TextEditingController();
    final controladorPassword = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.orangeAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("CookBook"),
        centerTitle: true,
        shadowColor: Colors.blue,
        // elevation: 30,
      ),
      body: Center(
        child: AnimatedContainer(
          constraints: BoxConstraints(
            minHeight: 600,
            minWidth: 1200,
          ),
          duration: Duration(milliseconds: 1000),
          alignment: Alignment(0, position),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 25,
                      blurRadius: 25),
                ],
              ),
              padding: EdgeInsets.all(30),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(25.0),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent[100],
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.person, size: 80, color: Colors.white,),
                      ),
                    ),
                    TextField(
                      controller: controladorNombre,
                      style: estilo,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Usuario:',
                        hintText: 'Usuario',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputCustom(controladorPassword),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // setState(() {
                          //   position=-12;
                          // });
                          Peticiones miPeticion = Peticiones(
                              Config.hostbase + "usuarios/identificacion");
                          String nombre = controladorNombre.text;
                          String password = controladorPassword.text;
                          Map<String, String> usuario = {
                            "nick": "${controladorNombre.text}",
                            "password": "${controladorPassword.text}"
                          };
                          var resultado =
                              await miPeticion.identificarse(usuario);
                          if (resultado != "No identificado") {
                            Map<String, dynamic> userLogin =
                                jsonDecode(resultado);
                            UsuarioSesion usuariosesion = UsuarioSesion();
                            usuariosesion.fromJson(userLogin);
                            CrearSesion().userSession(context, usuariosesion);
                            CrearSesion().activeSession(context);
                            // dynamic token = await FlutterSession().get("userLogin");
                            // print('-----------------');
                            // print(token['numeroTelefono']);
                            AccionesPrincipales.enlazar(
                                context, '/menuPrincipal');
                          } else {
                            final snackBar = SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_down,
                                    color: Colors.red,
                                  ),
                                  Text("   Usuario no registrado")
                                ],
                              ),
                              backgroundColor: Color.fromRGBO(10, 10, 10, 0.3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            CrearSesion().offSession(context);
                          }
                        },
                        label: Text('Identificame'),
                        icon: Icon(Icons.app_registration),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              TextStyle(height: 1, fontSize: 15)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                        ),
                      ),
                    )
                    // Ejemplo compañero
                    // InputField(controller: mycontrollerpassword, placeholder: "placeholder", icon: Icon(Icons.lock), password: true,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => centrarContainer());
  }

  void centrarContainer() {
    setState(() {
      position = 0;
    });
  }
}
