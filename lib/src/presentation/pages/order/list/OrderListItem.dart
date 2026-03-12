import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/bloc/OrderListState.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/view/OrderViewPage.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectConfirmDialog.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatelessWidget {
  OrderListBloc? bloc;
  OrderListState state;
  Order order;

  OrderListItem(this.bloc, this.state, this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    String estado;
    Color estadoColor;
    switch (order.estado) {
      case 'N':
        estado = 'Registrado';
        estadoColor = Colors.orange;
        break;
      case 'X':
        estado = 'Anulado';
        estadoColor = Colors.red;
        break;
      case 'P':
        estado = 'Pagado';
        estadoColor = Colors.green;
        break;
      default:
        estado = 'Otro';
        estadoColor = Colors.grey;
    }

    final cliente = order.cliente?.nombre ?? '';
    final productos = order.detalles.length;

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt_long, size: 20, color: Colors.grey),
                    SizedBox(width: 6),
                    Text(
                      'Venta #${order.secuencia}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _chipEstado(estado),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.person, size: 18, color: Colors.grey),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    cliente.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 18, color: Colors.grey),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    order.cliente?.email ?? 'N/A',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem(
                  Icons.attach_money,
                  'Total',
                  '\$${order.total.toStringAsFixed(2)}',
                ),
                _infoItem(
                  Icons.calendar_today,
                  'Fecha',
                  DateFormat('yyyy-MM-dd HH:mm').format(order.fecha),
                ),
                _infoItem(Icons.shopping_bag, 'Productos', '$productos'),
              ],
            ),

            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _actionButton(
                  icon: Icons.remove_red_eye,
                  color: Colors.deepPurple,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => OrderViewPage(order: order),
                    );
                  },
                ),
                const SizedBox(width: 8),

                _actionButton(
                  icon: Icons.monetization_on_outlined,
                  color: Colors.green,
                  onPressed: () {},
                ),

                const SizedBox(width: 8),
                _actionButton(
                  icon: Icons.print,
                  color: Colors.black87,
                  onPressed: () {
                    bloc?.add(GenerarPdfOrderListEvent(orden: order));
                  },
                ),

                const SizedBox(width: 8),

                _actionButton(
                  icon: Icons.share,
                  color: Colors.blue,
                  onPressed: () {
                    bloc?.add(CompartirPdfOrderListEvent(orden: order));
                  },
                ),

                const SizedBox(width: 8),

                _actionButton(
                  icon: Icons.close,
                  color: Colors.red,
                  onPressed: () {
                    if (order.estado == 'X') {
                      AppToast.warning('Venta ya se encuentra eliminada');
                    } else {
                      selectConfirmDialog(
                        context,
                        () => bloc?.add(DeleteOrderListEvent(id: order.id!)),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipEstado(String estado) {
    Color color;
    IconData icon;

    switch (order.estado) {
      case 'N':
        color = Colors.orange;
        icon = Icons.schedule;
        break;
      case 'X':
        color = Colors.red;
        icon = Icons.cancel;
        break;
      case 'P':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      default:
        color = Colors.grey;
        icon = Icons.info;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(
            estado,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey, fontSize: 11)),
            Text(
              value,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
      ),
    );
  }
}
