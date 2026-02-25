import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/OrderFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/searchProduct/SearchProductPage.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:vibration/vibration.dart';

class OrderFormContent extends StatelessWidget {
  OrderFormBloc? bloc;
  OrderFormState state;
  OrderFormContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFF1E3C72);
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: color,
              padding: EdgeInsets.only(top: 15, bottom: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Nueva Orden',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),

                child: Form(
                  key: state.formKey,

                  child: Column(
                    children: [
                      _container(
                        child: Container(
                          color: Colors.white,
                          child: _dropDownProvinciaSearch(),
                        ),
                      ),

                      SizedBox(height: 10),
                      _separador('Agregar Producto'),

                      SizedBox(height: 10),
                      SizedBox(
                        height: 65,
                        child: _container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: _botonBuscarPorCodigo(context),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                flex: 5,
                                child: _botonBuscarPorQr(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _separador(
                        '${state.orderDetail.length} Productos Agregados',
                      ),
                      state.orderDetail.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: state.orderDetail.length,
                                itemBuilder: (context, index) {
                                  return OrderFormItem(
                                    bloc,
                                    state.orderDetail[index],
                                  );
                                },
                              ),
                            )
                          : Text('No hay productos agregados'),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Subtotal:', style: TextStyle(fontSize: 16)),
                            Text('Impuestos:', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${state.subtotal.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '\$${state.impuestos.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('TOTAL:', style: TextStyle(fontSize: 16)),
                        Text(
                          '\$${state.total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DefaultButton(
                text: 'GUARDAR VENTA',
                onPressed: () {
                  if (state.formKey!.currentState!.validate()) {
                    bloc?.add(SubmittedOrderFormEvent());
                  } else {
                    AppToast.error('Formulario inválido');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _container({required Widget child}) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: child,
    );
  }

  Widget _dropDownProvinciaSearch() {
    return DropdownSearch<Client>(
      // Items como función
      items: (filter, infiniteScrollProps) {
        return state.listaClientes;
      },

      // Valor seleccionado
      selectedItem: state.idCliente.isEmpty
          ? null
          : state.listaClientes.firstWhereOrNull(
              (x) => x.id == state.idCliente,
            ),

      // Cómo mostrar cada item
      itemAsString: (Client x) => x.nombre,

      compareFn: (Client item1, Client item2) => item1.id == item2.id,

      // Cuando cambia la selección
      onChanged: (Client? cliente) {
        bloc?.add(ClienteChagnedOrderFormEvent(idCliente: cliente!.id));
      },
      // Configuración del popup de búsqueda
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Buscar cliente...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        emptyBuilder: (context, searchEntry) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('No se encontraron clientes'),
          ),
        ),
      ),

      // Decoración del dropdown
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'Cliente',
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
          errorText: state.idCliente.isEmpty
              ? 'Primero seleccione un cliente'
              : null,
        ),
      ),

      // Validación
      validator: (Client? city) {
        if (city == null) {
          return 'Seleccione un cliente';
        }
        return null;
      },
    );
  }

  Widget _botonBuscarPorCodigo(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //final result = await Navigator.pushNamed(context, 'searchProduct');
        //print('RESULT $result');
        final result = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,

          builder: (context) {
            return SearchProductPage(tipoLlamado: 'OV');
          },
        );

        if (result != null) {
          bloc?.add(BuscarProductOrderFormEvent(product: result));
        }
      },
      child: SizedBox(
        height: 45,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF1E3C72),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, color: Colors.white),
              Text(
                'Buscar Producto',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonBuscarPorQr(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(context, 'qrScanner');

        final hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator == true) {
          Vibration.vibrate(duration: 200); // sin await, y duración razonable
        }

        if (result != null) {
          bloc?.add(BuscarQrProductFormEvent(codAlterno: result.toString()));
        }
      },
      child: SizedBox(
        height: 45,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black45, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code, color: Colors.black54),
              Text(
                'Buscar por QR',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _separador(String texto) {
    return Row(
      children: [
        Text(
          texto,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 1, right: 3),
            height: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
