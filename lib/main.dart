import 'package:flutter/material.dart';

import 'package:app_gestor_v1/view/login.dart';
import 'package:app_gestor_v1/view/login_phone.dart';
import 'package:app_gestor_v1/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppYOQ',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Definimos la ruta inicial
      initialRoute: '/',
      // Definimos la lista de rutas en nuestra aplicación
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamda: ${settings.name}');

        return MaterialPageRoute(
            builder: (BuildContext context) => AccessPage());
      },
    );
  }
}
