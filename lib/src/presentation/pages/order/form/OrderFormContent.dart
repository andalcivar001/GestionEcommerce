import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/OrderFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/SearchProductPage.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class OrderFormContent extends StatelessWidget {
  final OrderFormBloc? bloc;
  final OrderFormState state;

  const OrderFormContent(this.bloc, this.state, {super.key});

  final Color primaryColor = const Color(0xFF1E3C72);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            _header(context),

            /// BODY
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: state.formKey,
                  child: Column(
                    children: [
                      _container(child: _dropDownCliente()),

                      const SizedBox(height: 12),

                      _separador('Agregar Producto'),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(child: _botonBuscarProducto(context)),
                          const SizedBox(width: 10),
                          Expanded(child: _botonQr(context)),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _separador('${state.orderDetail.length} Productos'),

                      const SizedBox(height: 8),

                      state.orderDetail.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: state.orderDetail.length,
                                itemBuilder: (_, index) {
                                  return OrderFormItem(
                                    bloc,
                                    state.orderDetail[index],
                                  );
                                },
                              ),
                            )
                          : const Expanded(
                              child: Center(
                                child: Text(
                                  "No hay productos agregados",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),

            /// TOTAL CARD
            _totales(),

            /// BOTON GUARDAR
            _guardarButton(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            "Nueva Orden",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _container({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _dropDownCliente() {
    return DropdownSearch<Client>(
      items: (filter, infiniteScrollProps) {
        return state.listaClientes;
      },
      selectedItem: state.idCliente.isEmpty
          ? null
          : state.listaClientes.firstWhereOrNull(
              (x) => x.id == state.idCliente,
            ),
      itemAsString: (Client x) => '${x.nombre} - ${x.numeroIdentificacion}',
      compareFn: (Client a, Client b) => a.id == b.id,
      onChanged: (Client? cliente) {
        bloc?.add(ClienteChagnedOrderFormEvent(idCliente: cliente!.id));
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            hintText: "Buscar cliente...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: "Cliente",
          prefixIcon: const Icon(Icons.person_outline),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      validator: (Client? c) {
        if (c == null) return 'Seleccione un cliente';
        return null;
      },
    );
  }

  Widget _botonBuscarProducto(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => SearchProductPage(tipoLlamado: 'OV'),
        );

        if (result != null) {
          bloc?.add(BuscarProductOrderFormEvent(product: result));
        }
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Buscar Producto",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botonQr(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(context, 'qrScanner');

        final hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator == true) {
          Vibration.vibrate(duration: 200);
        }

        if (result != null) {
          bloc?.add(BuscarQrProductFormEvent(codAlterno: result.toString()));
        }
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code),
            SizedBox(width: 8),
            Text("Escanear QR", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _separador(String texto) {
    return Row(
      children: [
        Text(
          texto,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  Widget _totales() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          _rowTotal("Subtotal", state.subtotal),

          const SizedBox(height: 6),

          _rowTotal("Impuestos", state.impuestos),

          const Divider(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "TOTAL",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "\$${state.total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rowTotal(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _guardarButton() {
    return Container(
      margin: const EdgeInsets.all(12),
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (state.formKey!.currentState!.validate()) {
            bloc?.add(SubmittedOrderFormEvent());
          } else {
            AppToast.error('Formulario inválido');
          }
        },
        child: Text(
          "GUARDAR VENTA",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
