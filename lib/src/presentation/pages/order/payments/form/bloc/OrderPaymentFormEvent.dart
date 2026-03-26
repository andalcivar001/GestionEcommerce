import 'package:equatable/equatable.dart';

abstract class OrderPaymentFormEvent extends Equatable {
  const OrderPaymentFormEvent();
  @override
  List<Object?> get props => [];
}

class InitOrderPaymentFormEvent extends OrderPaymentFormEvent {
  final String id;
  final String idOrden;
  const InitOrderPaymentFormEvent({required this.id, required this.idOrden});
  @override
  List<Object?> get props => [id, idOrden];
}

class MontoOrderPaymentFormEvent extends OrderPaymentFormEvent {
  final double monto;
  const MontoOrderPaymentFormEvent({required this.monto});
  @override
  List<Object?> get props => [monto];
}

class ReferenciaOrderPaymentFormEvent extends OrderPaymentFormEvent {
  final String referencia;
  const ReferenciaOrderPaymentFormEvent({required this.referencia});
  @override
  List<Object?> get props => [referencia];
}

class EntidadFinancieraOrderPaymentFormEvent extends OrderPaymentFormEvent {
  final String idEntidadFinanciera;
  const EntidadFinancieraOrderPaymentFormEvent({
    required this.idEntidadFinanciera,
  });
  @override
  List<Object?> get props => [idEntidadFinanciera];
}

class MetodoPagoOrderPaymentFormEvent extends OrderPaymentFormEvent {
  final String idPaymentMethod;
  const MetodoPagoOrderPaymentFormEvent({required this.idPaymentMethod});
  @override
  List<Object?> get props => [idPaymentMethod];
}

class ObservacionesOrderPaymentFormEvent extends OrderPaymentFormEvent {
  final String observaciones;
  const ObservacionesOrderPaymentFormEvent({required this.observaciones});
  @override
  List<Object?> get props => [observaciones];
}

class SubmittedOrderPaymentFormEvent extends OrderPaymentFormEvent {
  const SubmittedOrderPaymentFormEvent();
}
