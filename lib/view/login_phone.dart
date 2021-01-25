import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccessPhonePage extends StatefulWidget {
  // AccessPhonePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _AccessPhoneState createState() => _AccessPhoneState();
}

class _AccessPhoneState extends State<AccessPhonePage> {
  /*
  Properties
  */
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  // final TextEditingController _smsController = TextEditingController();
  // String _verificationId;
  // final SmsAutoFill _autoFill = SmsAutoFill();

  /*
  Desing Components
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App YOQ Phone'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[_createHeader(), _createPhone()],
      ),
    );
  }

  /*
  Metodos
  */
  Widget _createHeader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Icon(Icons.contact_support, size: 90.0),
    );
  }

  Widget _createPhone() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Phone',
          labelText: 'Phone number (+xx xxx-xxx-xxxx)',
          suffixIcon: Icon(Icons.phone_android),
          icon: Icon(Icons.phone)),
      onChanged: (valor) {
        _phoneNumberController.text = valor;
      },
    );
  }
}
