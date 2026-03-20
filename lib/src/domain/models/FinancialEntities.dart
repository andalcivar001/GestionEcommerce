// To parse this JSON data, do
//
//     final financialEntities = financialEntitiesFromJson(jsonString);

import 'dart:convert';

FinancialEntities financialEntitiesFromJson(String str) =>
    FinancialEntities.fromJson(json.decode(str));

String financialEntitiesToJson(FinancialEntities data) =>
    json.encode(data.toJson());

class FinancialEntities {
  String id;
  String nombre;
  String tipo;
  bool isActive;

  FinancialEntities({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.isActive,
  });

  factory FinancialEntities.fromJson(Map<String, dynamic> json) =>
      FinancialEntities(
        id: json["_id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nombre": nombre,
    "tipo": tipo,
    "isActive": isActive,
  };
}
