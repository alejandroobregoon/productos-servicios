import 'package:flutter/material.dart';
import 'package:productosservicios/models/producto_models.dart';
import 'package:productosservicios/pages/producto_page.dart';
import 'package:provider/provider.dart';

import '../services/products_service.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.greenAccent,
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 13),
        child: ListView.builder(
            itemCount: productsService.productos.length,
            itemBuilder: ( BuildContext context, int index ) => GestureDetector(
              onTap: () {

                productsService.selectedProduct = productsService.productos[index].copy();

              },
              child: Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.redAccent,
                  child: Icon(Icons.delete),
                ),
                onDismissed: (direccion){
                  productsService.deleteProduct(productsService.productos[index]);
                },
                child: ProductCard(
                  product: productsService.productos[index],
                ),
              ),
            )
        ),
      ),
      ////
      floatingActionButton: _crearBoton(context),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.greenAccent,
      child: const Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto', arguments: ProductsService()),
    );
  }

}
