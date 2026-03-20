// To parse this JSON data, do
//
//     final paymentMethod = paymentMethodFromJson(jsonString);

import 'dart:convert';

PaymentMethod paymentMethodFromJson(String str) =>
    PaymentMethod.fromJson(json.decode(str));

String paymentMethodToJson(PaymentMethod data) => json.encode(data.toJson());

class PaymentMethod {
  String id;
  String descripcion;
  String tipoPago;
  String abreviatura;
  bool requiereReferencia;
  bool isActive;

  PaymentMethod({
    required this.id,
    required this.descripcion,
    required this.tipoPago,
    required this.abreviatura,
    required this.requiereReferencia,
    required this.isActive,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["_id"],
    descripcion: json["descripcion"],
    tipoPago: json["tipoPago"],
    abreviatura: json["abreviatura"],
    requiereReferencia: json["requiereReferencia"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "descripcion": descripcion,
    "tipoPago": tipoPago,
    "abreviatura": abreviatura,
    "requiereReferencia": requiereReferencia,
    "isActive": isActive,
  };
}
