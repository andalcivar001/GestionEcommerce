import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderPaymentListState extends Equatable {
  final Order? orden;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  OrderPaymentListState({this.orden, this.response, this.formKey});

  OrderPaymentListState copyWith({
    Order? orden,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return OrderPaymentListState(
      orden: orden ?? this.orden,
      response: response ?? this.response,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [orden, response];
}
