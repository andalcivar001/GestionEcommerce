import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderFormState extends Equatable {
  final String idCliente;
  final List<OrderDetail> orderDetail;
  final double subtotal;
  final double impuestos;
  final double total;
  final String? idUsuario;
  final double? latitud;
  final double? longitud;
  final GlobalKey<FormState>? formKey;
  final Resource? response;
  final bool loading;
  final List<Client> listaClientes;

  OrderFormState({
    this.idCliente = '',
    this.orderDetail = const [],
    this.subtotal = 0,
    this.impuestos = 0,
    this.total = 0,
    this.idUsuario,
    this.latitud,
    this.longitud,
    this.formKey,
    this.response,
    this.loading = false,
    this.listaClientes = const [],
  });

  OrderFormState copyWith({
    String? idCliente,
    List<OrderDetail>? orderDetail,
    double? subtotal,
    double? impuestos,
    double? total,
    String? idUsuario,
    double? latitud,
    double? longitud,
    GlobalKey<FormState>? formKey,
    Resource? response,
    bool? loading,
    List<Client>? listaClientes,
  }) {
    return OrderFormState(
      idCliente: idCliente ?? this.idCliente,
      orderDetail: orderDetail ?? this.orderDetail,
      subtotal: subtotal ?? this.subtotal,
      impuestos: impuestos ?? this.impuestos,
      total: total ?? this.total,
      idUsuario: idUsuario ?? this.idUsuario,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      formKey: formKey,
      response: response,
      loading: loading ?? this.loading,
      listaClientes: listaClientes ?? this.listaClientes,
    );
  }

  @override
  List<Object?> get props => [
    idCliente,
    orderDetail,
    subtotal,
    impuestos,
    total,
    idUsuario,
    latitud,
    longitud,
    response,
    loading,
    listaClientes,
  ];
}
