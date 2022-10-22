import 'package:flutter/material.dart';
import 'package:productosservicios/models/producto_models.dart';

class ProductFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  ProductoModel product;

  ProductFormProvider( this.product );

  updateAvailability( bool value ) {
    print(value);
    this.product.disponible = value;
    notifyListeners();
  }


  bool isValidForm() {

    print( product.titulo );
    print( product.valor );
    print( product.disponible );

    return formKey.currentState?.validate() ?? false;
  }

}