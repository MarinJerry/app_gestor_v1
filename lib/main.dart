import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YORegistro',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'YoRegistro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*Properties */

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /*Methods */
  void _register() async {
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final FirebaseUser user = await _auth.currentUser();
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _auth.signOut();
                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'NOVA',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.deepOrange,
                    child: const Text('Create'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _register();
                      }
                    },
                  )),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.deepOrange[300],
                    child: const Text('Sign in'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                      );
                    },
                  )),
              Container(
                child: Text(_success == null
                    ? ''
                    : (_success
                        ? 'Successfully registered ' + _userEmail
                        : 'Upss, email already regitered')),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Text('NovaCode HN'),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //something
        },
        tooltip: 'Increment',
        child: Icon(Icons.lock_clock),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondRoute extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Categorias de Comercio'),
        ),
        body: new Container(
          padding: EdgeInsets.all(10),
          child: new FutureBuilder<List<User>>(
            future: fetchUsersFromGitHub(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(snapshot.data[index].name,
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold)),
                            new Divider()
                          ]);
                    });
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<List<User>> fetchUsersFromGitHub() async {
    final response = await http.get('https://yoqregistro.web.app/1003-1');
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<User> userList = createUserList(responseJson);
    return userList;
  }

  List<User> createUserList(List data) {
    List<User> list = new List();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["nombre"];
      String id = data[i]["id"];
      User user = new User(name: title, id: id);
      list.add(user);
    }
    return list;
  }
}

class User {
  String name;
  String id;
  User({this.name, this.id});
}
