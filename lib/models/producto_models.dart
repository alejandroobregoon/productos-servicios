// To parse this JSON data, do
//
//     final productoModel = productoModelFromMap(jsonString);

import 'dart:convert';

class ProductoModel {
  ProductoModel({
    this.id,
    required this.titulo,
    required this.valor,
    required this.disponible,
  });

  String? id;
  String titulo;
  double valor;
  bool disponible;

  factory ProductoModel.fromJson(String str) =>
      ProductoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductoModel.fromMap(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"].toDouble(),
        disponible: json["disponible"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
      };

  ProductoModel copy() => ProductoModel(
      id: id,
      titulo: titulo,
      valor: valor,
      disponible: disponible);
}
