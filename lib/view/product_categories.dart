import 'package:flutter/material.dart';
import 'package:app_gestor_v1/models/model_users.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SecondRoute extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
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

  /*Methods */
  Future<List<User>> fetchUsersFromGitHub() async {
    final response = await http.get(
        'https://us-central1-api-core-nova.cloudfunctions.net/app//P104134CATEG/r');
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<User> userList = createUserList(responseJson);
    return userList;
  }

  List<User> createUserList(List data) {
    List<User> list = new List();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["name"];
      String id = data[i]["id"];
      User user = new User(name: title, id: id);
      list.add(user);
    }
    return list;
  }
}
