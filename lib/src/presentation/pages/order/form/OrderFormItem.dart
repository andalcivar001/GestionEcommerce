import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:flutter/material.dart';

class OrderFormItem extends StatelessWidget {
  OrderFormBloc? bloc;
  OrderDetail detalle;
  OrderFormItem(this.bloc, this.detalle);

  @override
  Widget build(BuildContext context) {
    final subtotal = detalle.precio * detalle.cantidad;

    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.image, color: Colors.blue),
          ),
          SizedBox(width: 6),
          // descripcion + precio unitario
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detalle.producto?.descripcion ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  'Unit. \$${detalle.precio.toString()}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              '\$${subtotal.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _boton('-', () {
                  bloc?.add(RestarCantidadOrderFormEvent(orderDetail: detalle));
                }),
                _textoCantidad(),
                _boton('+', () {
                  bloc?.add(
                    AumentarCantidadOrderFormEvent(orderDetail: detalle),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _boton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade400, width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _textoCantidad() {
    return Container(
      width: 35,
      alignment: Alignment.center,
      child: Text(
        detalle.cantidad.toString(),
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
