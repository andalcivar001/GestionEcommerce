import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Order/OrderUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class OrderFormBloc extends Bloc<OrderFormEvent, OrderFormState> {
  OrderUseCases orderUseCases;
  ClientUseCases clientUseCases;
  ProductUseCases productUseCases;
  AuthUseCases authUseCases;

  OrderFormBloc(
    this.orderUseCases,
    this.clientUseCases,
    this.productUseCases,
    this.authUseCases,
  ) : super(OrderFormState()) {
    on<InitOrderFormEvent>(_onInit);
    on<ClienteChagnedOrderFormEvent>(_onClienteChanged);
    on<AumentarCantidadOrderFormEvent>(_onAumentarCantidad);
    on<RestarCantidadOrderFormEvent>(_onRestarCantidad);
    on<BuscarQrProductFormEvent>(_onBuscarQr);
    on<BuscarProductOrderFormEvent>(_onBuscarProduct);
    on<SubmittedOrderFormEvent>(_onSubmitted);
    on<ResetOrderFormEvent>(_onReset);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));

    final results = await Future.wait<Resource>([
      clientUseCases.getClients.run(),
      productUseCases.getProducts.run(),
    ]);

    final responseClientes = results[0];

    final List<Client> listaCliente = responseClientes is Success
        ? responseClientes.data as List<Client>
        : [];

    emit(
      state.copyWith(
        listaClientes: listaCliente,
        loading: false,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onClienteChanged(
    ClienteChagnedOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(idCliente: event.idCliente, formKey: formKey));
  }

  Future<void> _onAumentarCantidad(
    AumentarCantidadOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

    final index = nuevaLista.indexWhere(
      (x) => x.idProducto == event.orderDetail.idProducto,
    );

    if (index != -1) {
      final itemActual = nuevaLista[index];
      itemActual.cantidad = itemActual.cantidad + 1;
      nuevaLista[index] = itemActual;

      _calcularTotales(nuevaLista, emit);
    }
  }

  Future<void> _onRestarCantidad(
    RestarCantidadOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

    final index = nuevaLista.indexWhere(
      (x) => x.idProducto == event.orderDetail.idProducto,
    );

    if (index != -1) {
      OrderDetail itemActual = nuevaLista[index];

      if (itemActual.cantidad > 1) {
        itemActual.cantidad = itemActual.cantidad - 1;
        nuevaLista[index] = itemActual;
      } else {
        nuevaLista.removeAt(index);
      }

      _calcularTotales(nuevaLista, emit);
    }
  }

  void _calcularTotales(List<OrderDetail> lista, Emitter<OrderFormState> emit) {
    double subtotal = 0;

    for (var x in lista) {
      subtotal = subtotal + (x.cantidad * x.precio);
    }

    final impuestos = subtotal * 0.12;
    final total = subtotal + impuestos;

    emit(
      state.copyWith(
        orderDetail: lista,
        subtotal: subtotal,
        impuestos: impuestos,
        total: total,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBuscarProduct(
    BuscarProductOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));
    _agregarProducto(event.product, emit);
    emit(state.copyWith(loading: false, formKey: formKey));
  }

  Future<void> _onBuscarQr(
    BuscarQrProductFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(state.copyWith(loading: true, formKey: formKey));

    final response = await productUseCases.getByCodAlterno.run(
      event.codAlterno,
    );

    final Product? producto = response is Success
        ? response.data as Product
        : null;

    if (producto == null) {
      AppToast.error('Codigo de producto no existe');
      return;
    }
    _agregarProducto(producto, emit);
    emit(state.copyWith(loading: false, formKey: formKey));
  }

  void _agregarProducto(Product producto, Emitter<OrderFormState> emit) {
    final List<OrderDetail> nuevaLista = List.from(state.orderDetail);

    final index = nuevaLista.indexWhere((x) => x.idProducto == producto.id);

    if (index == -1) {
      final OrderDetail detalle = OrderDetail(
        idProducto: producto.id,
        precio: producto.precio ?? 0,
        cantidad: 1,
        producto: producto,
      );

      nuevaLista.add(detalle);
    } else {
      nuevaLista[index].cantidad = nuevaLista[index].cantidad + 1;
    }
    _calcularTotales(nuevaLista, emit);
  }

  Future<void> _onSubmitted(
    SubmittedOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    if (state.idCliente.isEmpty) {
      AppToast.warning('Seleccione el cliente');
      return;
    }

    if (state.orderDetail.isEmpty) {
      AppToast.warning('Ingrese por lo menos un producto');
      return;
    }

    if (state.total <= 0) {
      AppToast.warning('Total no puede ser 0');
      return;
    }

    emit(state.copyWith(response: Loading(), formKey: formKey));

    AuthResponse? authResponse = await authUseCases.getUserSession.run();

    await _obtenerUbicacion(emit);

    final double latitud = state.latitud ?? 0;
    final double longitud = state.longitud ?? 0;

    if (latitud == 0 || longitud == 0) {
      AppToast.error('No se pudo obtener la ubicación, imposible guardar');
      emit(state.copyWith(response: null, formKey: formKey));
      return;
    }

    final Order order = Order(
      fecha: DateTime.now(),
      idCliente: state.idCliente,
      subtotal: state.subtotal,
      impuestos: state.impuestos,
      total: state.total,
      idUsuario: authResponse!.user.id!,
      latitud: state.latitud,
      longitud: state.longitud,
      detalles: state.orderDetail,
    );

    final response = await orderUseCases.create.run(order);

    emit(state.copyWith(response: response, formKey: formKey));
  }

  Future<void> _obtenerUbicacion(Emitter<OrderFormState> emit) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppToast.error('Servicio de localización no esta habilitado');
      return;
    }

    // verifico permisos
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppToast.error('Permiso de ubicación denegado');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AppToast.error(
        'Permiso denegado permanentemente, Por favor habilitarlo desde ajustes',
      );
      return;
    }

    final Position position = await Geolocator.getCurrentPosition();

    emit(
      state.copyWith(
        latitud: position.latitude,
        longitud: position.longitude,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onReset(
    ResetOrderFormEvent event,
    Emitter<OrderFormState> emit,
  ) async {
    emit(OrderFormState());
  }
}
