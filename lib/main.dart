import 'package:flutter/material.dart';
import 'package:productosservicios/pages/home_page.dart';
import 'package:productosservicios/pages/login_page.dart';
import 'package:productosservicios/pages/producto_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(            //TODO:PROVIDER-ERROR
      child: MaterialApp(
        title: 'Productos',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context)=> LoginPage(),
          'home': (BuildContext context)=> HomePage(),
          'producto': (BuildContext context)=> ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}
