// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String? id;
  int? secuencia;
  DateTime fecha;
  String idCliente;
  double? latitud;
  double? longitud;
  List<OrderDetail> detalles;
  Client? cliente;
  User? usuario;
  double subtotal;
  double impuestos;
  double total;
  String idUsuario;
  String? estado;

  Order({
    this.id,
    this.secuencia,
    required this.fecha,
    required this.idCliente,
    this.latitud,
    this.longitud,
    required this.detalles,
    this.cliente,
    this.usuario,
    required this.subtotal,
    required this.impuestos,
    required this.total,
    required this.idUsuario,
    this.estado,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    secuencia: json["secuencia"],
    fecha: DateTime.parse(json["fecha"]),
    idCliente: json["idCliente"],
    latitud: json["latitud"]?.toDouble(),
    longitud: json["longitud"]?.toDouble(),
    detalles: (json["detalles"] as List)
        .map((x) => OrderDetail.fromJson(x))
        .toList(),
    cliente: json["cliente"] != null ? Client.fromJson(json["cliente"]) : null,
    usuario: json["usuario"] != null ? User.fromJson(json["usuario"]) : null,
    subtotal: json["subtotal"]?.toDouble(),
    impuestos: json["impuestos"]?.toDouble(),
    total: json["total"]?.toDouble(),
    idUsuario: json["idUsuario"],
    estado: json["estado"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "secuencia": secuencia,
    "fecha": fecha.toIso8601String(),
    "idCliente": idCliente,
    "latitud": latitud,
    "longitud": longitud,
    "detalles": detalles.map((x) => x.toJson()).toList(),
    "cliente": cliente,
    "usuario": usuario,
    "subtotal": subtotal,
    "impuestos": impuestos,
    "total": total,
    "idUsuario": idUsuario,
    "estado": estado,
  };

  static List<Order> fromJsonList(List<dynamic> jsonList) {
    List<Order> toList = [];
    jsonList.forEach((item) {
      Order client = Order.fromJson(item);
      toList.add(client);
    });
    return toList;
  }
}
