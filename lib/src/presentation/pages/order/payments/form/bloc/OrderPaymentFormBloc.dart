import 'package:collection/collection.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/models/PaymentMethod.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/OrderPayment/OrderPaymentUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentFormBloc
    extends Bloc<OrderPaymentFormEvent, OrderPaymentFormState> {
  OrderPaymentUseCases orderPaymentUseCases;
  OrderUseCases orderUseCases;
  OrderPaymentFormBloc(this.orderPaymentUseCases, this.orderUseCases)
    : super(OrderPaymentFormState()) {
    on<InitOrderPaymentFormEvent>(_onInit);
    on<MontoOrderPaymentFormEvent>(_onMontoChanged);
    on<ReferenciaOrderPaymentFormEvent>(_onReferenciaChanged);
    on<EntidadFinancieraOrderPaymentFormEvent>(_onEntidadFinancieraChanged);
    on<MetodoPagoOrderPaymentFormEvent>(_onMetodoPagoChanged);
    on<ObservacionesOrderPaymentFormEvent>(_onObservacionesChanged);
    on<SubmittedOrderPaymentFormEvent>(_onSubmitted);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    print('ENTRO AL BLOC');
    emit(state.copyWith(loading: true, formKey: formKey));
    final results = await Future.wait<Resource>([
      orderUseCases.getOrderById.run(event.idOrden),
      orderPaymentUseCases.getPaymentMethods.run(),
      orderPaymentUseCases.getFinancialEntities.run(),
    ]);

    OrderPayment? orderPayment;

    if (event.id.isNotEmpty) {
      final Resource responseOrderPayment = await orderPaymentUseCases
          .getOrderPaymentById
          .run(event.id);

      if (responseOrderPayment is Success) {
        orderPayment = responseOrderPayment.data as OrderPayment;
      }
    }

    emit(
      state.copyWith(
        id: event.id,
        idOrden: event.idOrden,
        loading: false,
        idPaymentMethod: orderPayment?.idPaymentMethod ?? '',
        idEntidadFinanciera: orderPayment?.idEntidadFinanciera ?? '',
        monto: orderPayment?.monto ?? 0,
        referencia: orderPayment?.referencia ?? '',
        observaciones: orderPayment?.observaciones ?? '',
        tipoMetodoPago: orderPayment?.metodoPago?.tipoPago ?? '',
        responseOrden: results[0],
        responseMetodoPago: results[1],
        responseEntidadFinanciera: results[2],
        formKey: formKey,
      ),
    );
  }

  Future<void> _onMontoChanged(
    MontoOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    emit(state.copyWith(monto: event.monto, formKey: formKey));
  }

  Future<void> _onReferenciaChanged(
    ReferenciaOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    emit(state.copyWith(referencia: event.referencia, formKey: formKey));
  }

  Future<void> _onEntidadFinancieraChanged(
    EntidadFinancieraOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    emit(
      state.copyWith(
        idEntidadFinanciera: event.idEntidadFinanciera,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onMetodoPagoChanged(
    MetodoPagoOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    final List<PaymentMethod> listaMetodoPago =
        state.responseMetodoPago is Success
        ? (state.responseMetodoPago as Success).data as List<PaymentMethod>
        : [];

    final PaymentMethod? metodoSeleccionado = listaMetodoPago.firstWhereOrNull(
      (metodo) => metodo.id == event.idPaymentMethod,
    );

    emit(
      state.copyWith(
        idPaymentMethod: event.idPaymentMethod,
        tipoMetodoPago: metodoSeleccionado?.tipoPago,
        idEntidadFinanciera:
            (metodoSeleccionado?.tipoPago ?? '').isEmpty ||
                metodoSeleccionado?.tipoPago == 'E'
            ? ''
            : state.idEntidadFinanciera,
        referencia: metodoSeleccionado?.requiereReferencia == true
            ? state.referencia
            : '',
        formKey: formKey,
      ),
    );
  }

  Future<void> _onObservacionesChanged(
    ObservacionesOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    emit(state.copyWith(observaciones: event.observaciones, formKey: formKey));
  }

  Future<void> _onSubmitted(
    SubmittedOrderPaymentFormEvent event,
    Emitter<OrderPaymentFormState> emit,
  ) async {
    final List<PaymentMethod> listaMetodoPago =
        state.responseMetodoPago is Success
        ? (state.responseMetodoPago as Success).data as List<PaymentMethod>
        : [];

    final PaymentMethod? metodoSeleccionado = listaMetodoPago.firstWhereOrNull(
      (metodo) => metodo.id == state.idPaymentMethod,
    );

    if ((state.idOrden ?? '').isEmpty) {
      AppToast.warning('No se encontro la orden para registrar el pago');
      return;
    }

    if ((state.idPaymentMethod ?? '').isEmpty) {
      AppToast.warning('Seleccione un metodo de pago');
      return;
    }

    if (state.monto <= 0) {
      AppToast.warning('Ingrese un monto mayor a 0');
      return;
    }

    if (metodoSeleccionado?.requiereReferencia == true) {
      if ((state.referencia ?? '').trim().isEmpty) {
        AppToast.warning('Ingrese la referencia del pago');
        return;
      }
      if ((state.idEntidadFinanciera ?? '').trim().isEmpty) {
        AppToast.warning('Seleccione una entidad financiera');
        return;
      }
    }

    emit(state.copyWith(response: Loading(), formKey: formKey));

    final OrderPayment orderPayment = OrderPayment(
      id: state.id,
      idOrden: state.idOrden ?? '',
      idPaymentMethod: state.idPaymentMethod ?? '',
      monto: state.monto,
      referencia: (state.referencia ?? '').trim(),
      idEntidadFinanciera: (state.idEntidadFinanciera ?? '').trim(),
      isActive: true,
      observaciones: (state.observaciones ?? '').trim(),
    );

    print('PAGO A GUARDAR ${orderPayment.toJson()}');

    final Resource response = state.id.isNotEmpty
        ? await orderPaymentUseCases.updateOrderPayment.run(
            orderPayment,
            state.id,
          )
        : await orderPaymentUseCases.createOrderPayment.run(orderPayment);

    emit(state.copyWith(response: response, formKey: formKey));
  }
}
