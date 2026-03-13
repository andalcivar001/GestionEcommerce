import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentListBloc
    extends Bloc<OrderPaymentListEvent, OrderPaymentListState> {
  OrderUseCases orderUseCases;
  OrderPaymentListBloc(this.orderUseCases) : super(OrderPaymentListState()) {
    on<InitOrderPaymentListEvent>(_onInit);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderPaymentListEvent event,
    Emitter<OrderPaymentListState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));
    final response = await orderUseCases.getOrderById.run(event.idOrden);
    emit(state.copyWith(response: response, formKey: formKey));
  }
}
