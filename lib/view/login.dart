import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:app_gestor_v1/view/login_phone.dart';

class AccessPage extends StatefulWidget {
  // AccessPage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _AccessPageState createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  /*Properties */
  String _message;
  String _userEmail;
  String _password;

  /*Methods */
  @override
  void dispose() {
    setState(() {
      _password = "";
    });
    setState(() {
      _userEmail = "";
    });
    super.dispose();
  }

  void _login() async {
    try {
      FirebaseUser user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _userEmail,
        password: _password,
      ))
              .user;
      if (user != null) {
        _message = "Acceso Concedido";
        _mostrarAlert(context, _message);
      }
    } catch (e) {
      // print(e);
      _message = "Credenciales no validas";
      _mostrarAlert(context, _message);
      dispose();
    }
  }

  /*Desing Components */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App YOQ'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _createHeader(),
          // Divider(),
          _createTitle(),
          // Divider(),
          _createInput(),
          Divider(),
          _createPassword(),
          // Divider(),
          _cretatebutton(),
          // Divider(),
          _crearBotones()
        ],
      ),
      // floatingActionButton: ,
    );
  }

  Widget _createHeader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Icon(Icons.contact_support, size: 90.0),
    );
  }

  Widget _createInput() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          // counter: Text('Letras ${_userEmail.length}'),
          hintText: 'Correo electronico',
          labelText: 'Email',
          // helperText: 'Sólo es el nombre',
          suffixIcon: Icon(Icons.account_circle),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _userEmail = valor;
        });
      },
    );
  }

  Widget _createPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _password = valor;
            }));
  }

  Widget _cretatebutton() {
    return Container(
        height: 55,
        padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.brown[200],
          child: const Text(
            'Ingresar',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          onPressed: () {
            _login();
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
        ));
  }

  Widget _createTitle() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Text(
          'Bienvenidos',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ));
  }

  Widget _crearBotones() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(width: 10),
            FloatingActionButton(
                child: Icon(Icons.phone_android),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'phone');
                }),
            SizedBox(width: 5.0),
            FloatingActionButton(child: Icon(Icons.mail), onPressed: null),
            SizedBox(width: 5.0),
            FloatingActionButton(
                child: Icon(Icons.person_add), onPressed: null),
          ],
        ));
  }

  void _mostrarAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Titulo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Text(message), FlutterLogo(size: 100.0)],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
