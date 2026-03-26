import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderPaymentFormState extends Equatable {
  final String id;
  final String? idOrden;
  final String? idPaymentMethod;
  final double monto;
  final String? referencia;
  final String? idEntidadFinanciera;
  final String? observaciones;
  final Resource? responseOrden;
  final Resource? responseMetodoPago;
  final Resource? responseEntidadFinanciera;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  final bool loading;
  final String? tipoMetodoPago;

  OrderPaymentFormState({
    this.id = '',
    this.idOrden,
    this.idPaymentMethod,
    this.monto = 0,
    this.referencia,
    this.idEntidadFinanciera,
    this.responseMetodoPago,
    this.responseEntidadFinanciera,
    this.response,
    this.observaciones,
    this.formKey,
    this.responseOrden,
    this.loading = false,
    this.tipoMetodoPago,
  });

  OrderPaymentFormState copyWith({
    String? id,
    String? idOrden,
    String? idPaymentMethod,
    double? monto,
    String? referencia,
    String? idEntidadFinanciera,
    Resource? responseOrden,
    Resource? responseMetodoPago,
    Resource? responseEntidadFinanciera,
    Resource? response,
    String? observaciones,
    GlobalKey<FormState>? formKey,
    bool? loading,
    String? tipoMetodoPago,
  }) {
    return OrderPaymentFormState(
      id: id ?? this.id,
      idOrden: idOrden ?? this.idOrden,
      idPaymentMethod: idPaymentMethod ?? this.idPaymentMethod,
      monto: monto ?? this.monto,
      referencia: referencia ?? this.referencia,
      idEntidadFinanciera: idEntidadFinanciera ?? this.idEntidadFinanciera,
      observaciones: observaciones ?? this.observaciones,
      responseMetodoPago: responseMetodoPago ?? this.responseMetodoPago,
      responseEntidadFinanciera:
          responseEntidadFinanciera ?? this.responseEntidadFinanciera,
      response: response ?? this.response,
      responseOrden: responseOrden ?? this.responseOrden,
      loading: loading ?? this.loading,
      tipoMetodoPago: tipoMetodoPago ?? this.tipoMetodoPago,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [
    id,
    idOrden,
    idPaymentMethod,
    monto,
    referencia,
    idEntidadFinanciera,
    observaciones,
    responseMetodoPago,
    responseEntidadFinanciera,
    responseOrden,
    response,
    tipoMetodoPago,
  ];
}
