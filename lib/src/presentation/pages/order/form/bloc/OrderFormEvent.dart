import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:equatable/equatable.dart';

abstract class OrderFormEvent extends Equatable {
  const OrderFormEvent();
  @override
  List<Object?> get props => [];
}

class InitOrderFormEvent extends OrderFormEvent {
  const InitOrderFormEvent();
}

class ClienteChagnedOrderFormEvent extends OrderFormEvent {
  final String idCliente;
  const ClienteChagnedOrderFormEvent({required this.idCliente});
  @override
  List<Object?> get props => [idCliente];
}

class SubmittedOrderFormEvent extends OrderFormEvent {
  const SubmittedOrderFormEvent();
}

class AumentarCantidadOrderFormEvent extends OrderFormEvent {
  final OrderDetail orderDetail;
  const AumentarCantidadOrderFormEvent({required this.orderDetail});
  @override
  // TODO: implement props
  List<Object?> get props => [orderDetail];
}

class RestarCantidadOrderFormEvent extends OrderFormEvent {
  final OrderDetail orderDetail;
  const RestarCantidadOrderFormEvent({required this.orderDetail});
  @override
  // TODO: implement props
  List<Object?> get props => [orderDetail];
}

class BuscarProductOrderFormEvent extends OrderFormEvent {
  final Product product;
  const BuscarProductOrderFormEvent({required this.product});
  @override
  List<Object?> get props => [product];
}

class BuscarQrProductFormEvent extends OrderFormEvent {
  final String codAlterno;
  const BuscarQrProductFormEvent({required this.codAlterno});
  @override
  List<Object?> get props => [codAlterno];
}

class ResetOrderFormEvent extends OrderFormEvent {
  const ResetOrderFormEvent();
}
