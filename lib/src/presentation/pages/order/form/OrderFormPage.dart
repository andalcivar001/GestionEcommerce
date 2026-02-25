import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/OrderFormContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderFormPage extends StatefulWidget {
  const OrderFormPage({super.key});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  OrderFormBloc? bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.add(InitOrderFormEvent());
    });
  }

  @override
  void dispose() {
    bloc?.add(ResetOrderFormEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OrderFormBloc>(context);
    return Scaffold(
      body: BlocListener<OrderFormBloc, OrderFormState>(
        listener: (context, state) {
          final response = state.response;
          if (response is Success) {
            AppToast.success('Venta guardada correctamente');
            context.read<OrderListBloc>().add(InitOrderListEvent());
            Navigator.pop(context);
          } else if (response is Error) {
            AppToast.error(
              'Hubo un error al guardar la venta ${response.message}',
            );
          }
        },
        child: BlocBuilder<OrderFormBloc, OrderFormState>(
          builder: (context, state) {
            final response = state.response;
            return Stack(
              children: [
                OrderFormContent(bloc, state),
                if (response is Loading || state.loading)
                  const Positioned.fill(
                    child: ColoredBox(
                      color: Color(0x66000000),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
