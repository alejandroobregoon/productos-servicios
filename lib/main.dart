import 'package:flutter/material.dart';
import 'package:productosservicios/pages/home_page.dart';
import 'package:productosservicios/pages/login_page.dart';
import 'package:productosservicios/pages/producto_page.dart';
import 'package:productosservicios/services/products_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ProductsService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos',
      initialRoute: 'home',
      routes: {
        'login': (_)=> LoginPage(),
        'home': (_)=> HomePage(),
        'producto': (_)=> ProductoPage(),
      },
      theme: ThemeData(
          primaryColor: Colors.deepPurple
      ),
    );
  }
}