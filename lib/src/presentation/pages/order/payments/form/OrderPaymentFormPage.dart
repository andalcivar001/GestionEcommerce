import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/OrderPaymentFormContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentFormPage extends StatefulWidget {
  const OrderPaymentFormPage({super.key});

  @override
  State<OrderPaymentFormPage> createState() => _OrderPaymentFormPageState();
}

class _OrderPaymentFormPageState extends State<OrderPaymentFormPage> {
  OrderPaymentFormBloc? bloc;
  String? id;
  String? idOrden;
  bool _initialized = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _initialized) return;
      bloc = BlocProvider.of<OrderPaymentFormBloc>(context);
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      if (args.isNotEmpty) {
        id = args['id'];
        idOrden = args['idOrden'];
        bloc?.add(
          InitOrderPaymentFormEvent(id: id ?? '', idOrden: idOrden ?? ''),
        );
        _initialized = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<OrderPaymentFormBloc>(context);
    return Scaffold(
      body: BlocListener<OrderPaymentFormBloc, OrderPaymentFormState>(
        listenWhen: (previous, current) =>
            previous.response != current.response ||
            previous.responseEntidadFinanciera !=
                current.responseEntidadFinanciera ||
            previous.responseMetodoPago != current.responseMetodoPago,
        listener: (context, state) {
          final response = state.response;
          final responseEntidadFinanciera = state.responseEntidadFinanciera;
          final responseMetodoPago = state.responseMetodoPago;
          if (response is Error) {
            AppToast.error(
              'Hubo un error al guardar el pago ${response.message}',
            );
          } else if (response is Success) {
            AppToast.success('Pago guardado correctamente');
            Navigator.pop(context, true);
          }

          if (responseEntidadFinanciera is Error) {
            AppToast.error(
              'Hubo un error al consultar las entidades financieras  ${responseEntidadFinanciera.message}',
            );
          }

          if (responseMetodoPago is Error) {
            AppToast.error(
              'Hubo un error al cargar los metodos de pago ${responseMetodoPago.message}',
            );
          }
        },
        child: BlocBuilder<OrderPaymentFormBloc, OrderPaymentFormState>(
          builder: (context, state) {
            final response = state.response;
            return Stack(
              children: [
                OrderPaymentFormcontent(bloc, state),
                if (response is Loading || state.loading)
                  Positioned.fill(
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
