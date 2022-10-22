import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productosservicios/models/producto_models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'proyecto-flutter-productos-default-rtdb.firebaseio.com';
  // final String _baseUrl = 'flutter-varios02-default-rtdb.firebaseio.com';
  final List<ProductoModel> productos = [];
  late ProductoModel selectedProduct;
  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }
  Future<List<ProductoModel>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https( _baseUrl, 'productos.json');
    final resp = await http.get( url );

    final Map<String, dynamic> productsMap = json.decode( resp.body );

    productsMap.forEach((key, value) {
      final tempProduct = ProductoModel.fromMap( value );
      tempProduct.id = key;
      productos.add( tempProduct );
    });
    isLoading = false;
    notifyListeners();
    return productos;
  }

  Future saveOrCreateProduct( ProductoModel product ) async {
    isSaving = true;
    notifyListeners();
    if ( product.id == null ) {
      // Es necesario crear
      await this.createProduct( product );
    } else {
      // Actualizar
      await this.updateProduct( product );
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct( ProductoModel product ) async {
    final url = Uri.https( _baseUrl, 'productos/${ product.id }.json');
    final resp = await http.put( url, body: product.toJson() );
    final decodedData = resp.body;

    //TODO: Actualizar el listado de productos
    final index = this.productos.indexWhere((element) => element.id == product.id );
    this.productos[index] = product;
    print(decodedData); //TODO : NO VA ESTO
    return product.id!;

  }

  Future<String> createProduct( ProductoModel product ) async {
    final url = Uri.https( _baseUrl, 'productos.json');
    final resp = await http.post( url, body: product.toJson() );
    final decodedData = json.decode( resp.body );
    product.id = decodedData['name'];
    productos.add(product);
    return product.id!;
  }

  Future<String> deleteProduct( ProductoModel product ) async {
    final url = Uri.https( _baseUrl, 'productos/${ product.id }.json');
    final resp = await http.delete( url, body: product.toJson() );
    print(resp.body);
    return product.id!;
  }

}