import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/material.dart';
import 'package:tpv/controladores/accionesPrincipales.dart';
import 'package:tpv/controladores/createSession.dart';
import 'package:tpv/widget/inputFieldCustom.dart';

 class Login extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
     return _LoginState();
   }
 }





class _LoginState extends State<Login> {
  final estilo = TextStyle(fontSize: 18, color: Colors.lightBlue, height: 1);

  bool mover = false;
  double position = -10;
  //var mycontrollerpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          backgroundColor: Colors.orangeAccent[100],
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Text("My Title"),
            centerTitle: true,
            shadowColor: Colors.blue,
            elevation: 30,
          ),
          body:  Center(
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
                  BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 25, blurRadius: 25),
                  ],
                  ),
                  padding: EdgeInsets.all(30),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                                TextField(style: estilo,
                                  textAlign: TextAlign.center,
                                  decoration:
                                    InputDecoration(
                                      isDense: true,
                                        prefixIcon: Icon(Icons.person),
                                        labelText: 'Usuario:',
                                        hintText: 'Usuario',
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                        ),
                                        focusColor: Colors.black,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),

                                    ),

                                ),
                                SizedBox(height: 10,),
                                InputCustom(),
                                SizedBox(height: 10,),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton.icon(
                                      onPressed: (){
                                        // setState(() {
                                        //   position=-12;
                                        // });
                                        CrearSesion().saveData(context);

                                        AccionesPrincipales.enlazar(context, '/menuPrincipal');

                                      },
                                      label: Text('Identificame'),
                                      icon: Icon(Icons.app_registration),
                                      style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(TextStyle(height: 1, fontSize: 15)),
                                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),

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
  void initState(){
    super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) => centrarContainer());

  }

  void centrarContainer(){
    setState(() {
      position=0;
     });
  }

}