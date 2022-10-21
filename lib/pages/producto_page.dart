import 'package:flutter/material.dart';

class ProductoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
          labelText: 'Nombre'
      ),
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el nombre del Producto';
        } else {
          return null;
        }
      },
    );
  }

  _crearPrecio() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
          labelText: 'Precio'
      ),
    );
  }
}

