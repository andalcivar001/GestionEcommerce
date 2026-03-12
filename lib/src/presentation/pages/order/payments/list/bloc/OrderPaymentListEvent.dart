import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:equatable/equatable.dart';

abstract class OrderPaymentListEvent extends Equatable {
  const OrderPaymentListEvent();
  @override
  List<Object?> get props => [];
}

class InitOrderPaymentListEvent extends OrderPaymentListEvent {
  final String idOrden;
  const InitOrderPaymentListEvent({required this.idOrden});
  @override
  List<Object?> get props => [idOrden];
}
