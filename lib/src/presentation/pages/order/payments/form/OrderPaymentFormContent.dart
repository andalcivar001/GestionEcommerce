import 'package:collection/collection.dart';
import 'package:ecommerce_prueba/src/domain/models/FinancialEntities.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/PaymentMethod.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/payments/form/bloc/OrderPaymentFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultSearchableDropdown.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPaymentFormcontent extends StatelessWidget {
  OrderPaymentFormBloc? bloc;
  OrderPaymentFormState state;
  OrderPaymentFormcontent(this.bloc, this.state, {super.key});

  static const Color _primaryColor = Color(0xFF163D73);
  static const Color _accentColor = Color(0xFF2F80ED);
  static const Color _backgroundColor = Color(0xFFF4F7FB);

  @override
  Widget build(BuildContext context) {
    final Order? orden = state.responseOrden is Success
        ? (state.responseOrden as Success).data as Order
        : null;

    double saldo = orden != null ? orden.total - (orden.totalPagado ?? 0) : 0;
    String fecha = '';
    String nombreCliente = '';
    int secuencia = 0;

    if (orden != null) {
      secuencia = orden.secuencia ?? 0;
      fecha = DateFormat('yyyy-MM-dd HH:mm').format(orden.fecha);
      nombreCliente = orden.cliente?.nombre ?? '';
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: _backgroundColor,
          child: Column(
            children: [
              _header(context, secuencia, saldo),
              Transform.translate(
                offset: Offset(0, -24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _summaryCard(
                        nombreCliente: nombreCliente,
                        fecha: fecha,
                        total: saldo,
                      ),
                      SizedBox(height: 16),
                      _paymentFormCard(
                        requiereReferencia: state.requiereReferencia,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, int secuencia, double total) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18, 18, 18, 56),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primaryColor, _accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Venta #$secuencia',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'Registrar pago',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Completa los datos del cobro con un flujo claro y elegante.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.payments_outlined, color: Colors.white),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saldo pendiente',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required String nombreCliente,
    required String fecha,
    required double total,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen de la venta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _primaryColor,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Verifica los datos antes de registrar el pago.',
            style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 13),
          ),
          SizedBox(height: 18),
          _infoTile(
            icon: Icons.person_outline,
            label: 'Cliente',
            value: nombreCliente.isEmpty
                ? 'Sin cliente asignado'
                : nombreCliente,
          ),
          SizedBox(height: 12),
          _infoTile(
            icon: Icons.schedule_outlined,
            label: 'Fecha',
            value: fecha.isEmpty ? 'Sin fecha' : fecha,
          ),
          SizedBox(height: 12),
          _infoTile(
            icon: Icons.attach_money_outlined,
            label: 'Saldo',
            value: '\$${total.toStringAsFixed(2)}',
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: highlight ? Color(0xFFEAF3FF) : Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: highlight
                  ? _accentColor
                  : _primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: highlight ? Colors.white : _primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.blueGrey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: highlight ? 18 : 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentFormCard({required bool requiereReferencia}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Form(
        key: state.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAF3FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: _accentColor,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detalle del pago',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Selecciona el metodo y completa la informacion financiera.',
                        style: TextStyle(
                          color: Colors.blueGrey.shade500,
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _sectionLabel('Metodo de pago'),
            SizedBox(height: 8),
            _metodoPago(),
            SizedBox(height: 16),
            _sectionLabel('Monto a registrar'),
            SizedBox(height: 8),
            _textMonto(),
            SizedBox(height: 16),

            if (requiereReferencia) ...[
              _sectionLabel('Entidad financiera'),
              SizedBox(height: 8),
              _entidadFinancieraSearch(),
              SizedBox(height: 16),
              _sectionLabel('Referencia'),
              SizedBox(height: 8),
              _textReferencia(),
              SizedBox(height: 16),
            ],
            _sectionLabel('Observaciones'),
            SizedBox(height: 8),
            _textObservaciones(),
            SizedBox(height: 24),
            _buttonGuardar(),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Colors.blueGrey.shade700,
        letterSpacing: 0.2,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0E2A4F).withValues(alpha: 0.08),
          blurRadius: 28,
          offset: Offset(0, 14),
        ),
      ],
    );
  }

  Widget _textMonto() {
    return DefaultTextField(
      key: ValueKey('monto-${state.id}'),
      label: 'Monto',
      icon: Icons.monetization_on,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      initialValue: state.monto.toString(),
      hinText: 'Ingresa el valor pagado',
      onChanged: (text) {
        bloc?.add(
          MontoOrderPaymentFormEvent(monto: double.tryParse(text) ?? 0),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el monto';
        }
        return null;
      },
    );
  }

  Widget _textReferencia() {
    return DefaultTextField(
      key: ValueKey('referencia-${state.id}'),
      label: 'Referencia',
      icon: Icons.receipt_long_outlined,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      initialValue: state.referencia ?? '',
      hinText: 'Ingresa el numero o codigo de referencia',
      onChanged: (text) {
        bloc?.add(ReferenciaOrderPaymentFormEvent(referencia: text));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Ingrese la referencia';
        }
        return null;
      },
    );
  }

  Widget _textObservaciones() {
    return DefaultTextField(
      key: ValueKey('observaciones-${state.id}'),
      label: 'Observaciones',
      icon: Icons.notes_outlined,
      textInputAction: TextInputAction.done,
      initialValue: state.observaciones ?? '',
      maxLines: 3,
      hinText: 'Agrega un comentario opcional',
      onChanged: (text) {
        bloc?.add(ObservacionesOrderPaymentFormEvent(observaciones: text));
      },
    );
  }

  Widget _buttonGuardar() {
    return DefaultButton(
      text: state.id.isEmpty ? 'Guardar pago' : 'Actualizar pago',
      color: _accentColor,
      onPressed: () {
        if (state.formKey?.currentState?.validate() ?? false) {
          bloc?.add(const SubmittedOrderPaymentFormEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
    );
  }

  Widget _metodoPago() {
    final List<PaymentMethod> listaMetodoPago =
        state.responseMetodoPago is Success
        ? (state.responseMetodoPago as Success).data as List<PaymentMethod>
        : [];

    return DropdownButtonFormField<String>(
      key: ValueKey('idPaymentMethod-${state.id}'),
      initialValue: (state.idPaymentMethod?.isNotEmpty ?? false)
          ? state.idPaymentMethod
          : null,
      decoration: InputDecoration(
        labelText: 'Metodo de pago',
        prefixIcon: Icon(Icons.payment_outlined),
        filled: true,
        fillColor: Color(0xFFF8FAFD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: _accentColor, width: 1.4),
        ),
      ),
      items: listaMetodoPago.map((metodo) {
        return DropdownMenuItem<String>(
          value: metodo.id,
          child: Text(metodo.descripcion),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        bloc?.add(MetodoPagoOrderPaymentFormEvent(idPaymentMethod: value));
      },
    );
  }

  Widget _entidadFinancieraSearch() {
    final tipoMetodoPago = state.tipoMetodoPago ?? '';

    final entidadesFinancieras = state.responseEntidadFinanciera is Success
        ? (state.responseEntidadFinanciera as Success).data
              as List<FinancialEntities>
        : <FinancialEntities>[];

    final entidades = entidadesFinancieras
        .where((x) => x.tipo == tipoMetodoPago)
        .toList();

    return tipoMetodoPago.isEmpty || tipoMetodoPago == 'E'
        ? Container()
        : DefaultSearchableDropdown<FinancialEntities>(
            key: ValueKey('idEntidadFinanciera-${state.id}'),
            items: entidades,
            selectedItem: entidades.firstWhereOrNull(
              (entidad) => entidad.id == state.idEntidadFinanciera,
            ),
            labelText: 'Entidad financiera',
            hintText: 'Buscar entidad financiera...',
            prefixIcon: Icons.account_balance,
            emptyText: 'No se encontraron entidades financieras',
            itemAsString: (entidad) => entidad.nombre,
            compareFn: (item, selected) => item.id == selected.id,
            onChanged: (entidad) {
              bloc?.add(
                EntidadFinancieraOrderPaymentFormEvent(
                  idEntidadFinanciera: entidad.id,
                ),
              );
            },
            validator: (entidad) {
              if (entidad == null) {
                return 'Seleccione una entidad financiera';
              }
              return null;
            },
          );
  }
}
