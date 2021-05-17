import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget{
  TextEditingController controllerPassword;

  InputCustom(this.controllerPassword);

  @override
  _InputCustomState createState() => _InputCustomState();


}
class _InputCustomState extends State<InputCustom>{
  TextStyle estilo;
  bool _mostraSecret;
  @override
  void initState() {
    super.initState();
    estilo = TextStyle(fontSize: 18,
        color: Colors.lightBlue, height: 1);
    _mostraSecret=true;
  }
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controllerPassword,
      style: estilo,
      textAlign: TextAlign.center,
      autocorrect: false,
      keyboardType: TextInputType.text,
      obscureText: _mostraSecret,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Contraseña:',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(15.0))),
        hintText: 'Contraseña',
        hintStyle: TextStyle(color: Colors.black54),
        focusColor: Colors.black,
        suffixIcon: GestureDetector(
          onTap: (){
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
    );
  }

}