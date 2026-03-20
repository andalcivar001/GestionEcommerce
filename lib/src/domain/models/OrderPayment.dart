// To parse this JSON data, do
//
//     final orderPayment = orderPaymentFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_prueba/src/domain/models/FinancialEntities.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/PaymentMethod.dart';

OrderPayment orderPaymentFromJson(String str) =>
    OrderPayment.fromJson(json.decode(str));

String orderPaymentToJson(OrderPayment data) => json.encode(data.toJson());

class OrderPayment {
  String? id;
  String idOrden;
  String idPaymentMethod;
  double monto;
  String? referencia;
  String? idEntidadFinanciera;
  bool isActive;
  Order? order;
  PaymentMethod? metodoPago;
  FinancialEntities? entidadFinanciera;

  OrderPayment({
    this.id,
    required this.idOrden,
    required this.idPaymentMethod,
    required this.monto,
    this.referencia,
    this.idEntidadFinanciera,
    required this.isActive,
    this.order,
    this.metodoPago,
    this.entidadFinanciera,
  });

  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
    id: json["_id"] ?? '',
    idOrden: json["idOrden"],
    idPaymentMethod: json["idPaymentMethod"],
    monto: json["monto"]?.toDouble(),
    referencia: json["referencia"] ?? '',
    idEntidadFinanciera: json["idEntidadFinanciera"] ?? '',
    isActive: json["isActive"],
    order: json["order"] != null ? Order.fromJson(json["order"]) : null,
    metodoPago: json["metodoPago"] != null
        ? PaymentMethod.fromJson(json["metodoPago"])
        : null,
    entidadFinanciera: json["entidadFinanciera"] != null
        ? FinancialEntities.fromJson(json["entidadFinanciera"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "idOrden": idOrden,
    "idPaymentMethod": idPaymentMethod,
    "monto": monto,
    "referencia": referencia,
    "idEntidadFinanciera": idEntidadFinanciera,
    "isActive": isActive,
    "order": order,
    "metoodPago": metodoPago,
    "entidadFinanciera": entidadFinanciera,
  };

  static List<OrderPayment> fromJsonList(List<dynamic> jsonList) {
    List<OrderPayment> toList = [];
    jsonList.forEach((item) {
      OrderPayment client = OrderPayment.fromJson(item);
      toList.add(client);
    });
    return toList;
  }
}
