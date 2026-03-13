import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/OrderPaymentListContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/list/bloc/OrderPaymentListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentListPage extends StatefulWidget {
  const OrderPaymentListPage({super.key});

  @override
  State<OrderPaymentListPage> createState() => _OrderPaymentListPageState();
}

class _OrderPaymentListPageState extends State<OrderPaymentListPage> {
  String idOrden = '';
  OrderPaymentListBloc? bloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.add(InitOrderPaymentListEvent(idOrden: idOrden));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      idOrden = ModalRoute.of(context)?.settings.arguments as String;
    }
    bloc = BlocProvider.of<OrderPaymentListBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocListener<OrderPaymentListBloc, OrderPaymentListState>(
          listener: (context, state) {
            final response = state.response;
            if (response is Error) {
              AppToast.error(
                'Hubo un problema al consultar la orden ${response.message}',
              );
            }
          },
          child: BlocBuilder<OrderPaymentListBloc, OrderPaymentListState>(
            builder: (context, state) {
              final response = state.response;
              if (response is Loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (response is Success) {
                final Order orden = response.data as Order;
                return OrderPaymentListContent(orden: orden);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
