// To parse this JSON data, do
//
//     final orderPayment = orderPaymentFromJson(jsonString);

import 'dart:convert';

OrderPayment orderPaymentFromJson(String str) =>
    OrderPayment.fromJson(json.decode(str));

String orderPaymentToJson(OrderPayment data) => json.encode(data.toJson());

class OrderPayment {
  String? id;
  String idOrden;
  String idPaymentMethod;
  int monto;
  String? referencia;
  String? idEntidadFinanciera;
  bool isActive;

  OrderPayment({
    this.id,
    required this.idOrden,
    required this.idPaymentMethod,
    required this.monto,
    this.referencia,
    this.idEntidadFinanciera,
    required this.isActive,
  });

  factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
    id: json["_id"] ?? '',
    idOrden: json["idOrden"],
    idPaymentMethod: json["idPaymentMethod"],
    monto: json["monto"]?.toDouble(),
    referencia: json["referencia"] ?? '',
    idEntidadFinanciera: json["idEntidadFinanciera"] ?? '',
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "idOrden": idOrden,
    "idPaymentMethod": idPaymentMethod,
    "monto": monto,
    "referencia": referencia,
    "idEntidadFinanciera": idEntidadFinanciera,
    "isActive": isActive,
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
