import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productosservicios/models/producto_models.dart';
import 'package:provider/provider.dart';

import '../providers/product_form_provider.dart';
import '../services/products_service.dart';
import '../ui/input_decorations.dart';

class ProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(
          ProductoModel(titulo: '', valor: 0, disponible: true)),
      child: _ProductScreenBody(productService: productService),
    );
  }

// _crearNombre() {
//   return TextFormField(
//     // initialValue: producto.titulo,
//     textCapitalization: TextCapitalization.sentences,
//     decoration: InputDecoration(labelText: 'Nombre'),
//     // onSaved: (value) => producto.titulo = value!,
//     // validator: (value) {
//     //   if (value!.length < 3) {
//     //     return 'Ingrese el nombre del Producto';
//     //   } else {
//     //     return null;
//     //   }
//     // },
//   );
// }

// _crearPrecio() {
//   return TextFormField(
//     keyboardType: TextInputType.number,
//     // initialValue: producto.valor.toString(),
//     textCapitalization: TextCapitalization.sentences,
//     decoration: InputDecoration(labelText: 'Precio'),
//     // onSaved: (value) => producto.valor = double.parse(value!),
//     // validator: (value) {
//     //   if (utils.isNumeric(value!)) {
//     //     return null;
//     //   } else {
//     //     return 'Solo numeros';
//     //   }
//     // },
//   );
// }

// _crearBoton() {
//   return Container(
//     height: 200,
//     alignment: Alignment.center,
//     padding: EdgeInsets.all(20),
//     child: ElevatedButton.icon(
//       onPressed: (){},
//       icon: const Icon(Icons.save),
//       label: const Text('Guardar'),
//       style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.purple,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0))),
//     ),
//   );
// }

// void _submit() {
//   if (!formkey.currentState!.validate()) return;
//   formkey.currentState?.save();
//
//   // print(producto.titulo);
//   // print(producto.valor);
//   // print(producto.disponible);
// }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            SizedBox(height: 100),
            _ProductForm(),
            SizedBox(height: 10),
            Container(
                height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: ElevatedButton.icon(
                    onPressed: productService.isSaving
                        ? null
                        : () async {
                            if (!productForm.isValidForm()) return;

                            await productService
                                .saveOrCreateProduct(productForm.product);
                          },
                    icon: productService.isSaving
                          ? CircularProgressIndicator(color: Colors.white)
                          : Icon(Icons.save_outlined),
                    label: Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))))),
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: productService.isSaving
      //       ? CircularProgressIndicator(color: Colors.white)
      //       : Icon(Icons.save_outlined),
      //   onPressed: productService.isSaving
      //       ? null
      //       : () async {
      //     if (!productForm.isValidForm()) return;
      //
      //     await productService.saveOrCreateProduct(productForm.product);
      //   },
      // ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 50),
              TextFormField(
                initialValue: product.titulo,
                onChanged: (value) => product.titulo = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del producto', labelText: 'Nombre:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.valor}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.valor = 0;
                  } else {
                    product.valor = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '\$150', labelText: 'Precio:'),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                  value: product.disponible,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: productForm.updateAvailability),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
