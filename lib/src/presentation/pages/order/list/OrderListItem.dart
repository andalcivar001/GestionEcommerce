import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatelessWidget {
  OrderListBloc? bloc;
  Order order;
  OrderListItem(this.bloc, this.order);

  @override
  Widget build(BuildContext context) {
    String estado;
    switch (order.estado) {
      case 'N':
        estado = 'Registrado';
        break;
      case 'X':
        estado = 'Anulado';
        break;
      case 'P':
        estado = 'Pagado';
        break;
      default:
        estado = 'Otro';
    }
    String cliente = order.cliente?.nombre ?? '';
    int productos = order.detalles.length;

    return Card(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            dense: true,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Venta #', style: TextStyle(fontSize: 15)),
                Text(
                  order.secuencia.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: _chipId(estado),
          ),
          _divider(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text('Cliente:', style: TextStyle(fontSize: 13)),
                SizedBox(width: 2),

                Text(
                  cliente.toUpperCase(),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Total: ', style: TextStyle(fontSize: 13)),
                _textTotal(),
                Spacer(flex: 1),
                Text('Fecha: ', style: TextStyle(fontSize: 13)),

                Text(
                  DateFormat('yyyy-MM-dd').format(order.fecha),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _divider(),
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.cliente?.email ?? 'N/A'),
                Text('${productos.toString()} productos'),
              ],
            ),
          ),
          _divider(),
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Consultar'),
                    icon: Icon(Icons.search),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Eliminar'),
                    icon: Icon(Icons.cancel),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chipId(String estado) {
    Color color = Colors.blue;
    IconData icon = Icons.add;
    switch (order.estado) {
      case 'N':
        color = Colors.yellow.shade700;
        icon = Icons.new_label;
        break;
      case 'X':
        color = Colors.red;
        icon = Icons.close;
        break;
      case 'P':
        color = Colors.green;
        icon = Icons.check_circle;

        break;
    }
    return SizedBox(
      width: 130,
      height: 28,

      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              estado.toUpperCase(),
              style: TextStyle(
                color: order.estado == 'N' ? Colors.black : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1, // espacio total que ocupa
      thickness: 1, // ancho de la linea
      color: Colors.grey,
      indent: 10, // margen izquierdo
      endIndent: 10, // margen derecho
    );
  }

  Widget _textTotal() {
    final double total = order.total;
    return Text(
      '\$${total.toStringAsFixed(2)}',
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    );
  }
}
