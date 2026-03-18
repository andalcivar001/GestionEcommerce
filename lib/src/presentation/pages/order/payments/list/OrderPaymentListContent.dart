import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:flutter/material.dart';

class OrderPaymentListContent extends StatelessWidget {
  final Order orden;

  OrderPaymentListContent({required this.orden, super.key});

  @override
  Widget build(BuildContext context) {
    orden.totalPagado = 60;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),

            Padding(
              padding: const EdgeInsets.all(12),
              child: _cardOrden(
                chipEstado: _chipEstado(),
                nombre: orden.cliente?.nombre ?? 'n/a',
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Detalle de pagos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔷 HEADER
  Widget _header(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            'Pagos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 💳 CARD PRINCIPAL
  Widget _cardOrden({required Widget chipEstado, required String nombre}) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // 👤 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Venta #${orden.secuencia}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                chipEstado,
              ],
            ),

            const SizedBox(height: 15),

            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 10),

            _barraProgresiva(),

            const SizedBox(height: 15),

            // 💰 VALORES
            Row(
              children: [
                Expanded(
                  child: _cardValores(
                    icon: Icons.attach_money,
                    color: Colors.blue,
                    label: 'Total',
                    value: '\$${orden.total.toStringAsFixed(2)}',
                  ),
                ),
                Expanded(
                  child: _cardValores(
                    icon: Icons.check_circle,
                    color: Colors.green,
                    label: 'Pagado',
                    value: '\$${(orden.totalPagado ?? 0).toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _cardValores(
                    icon: Icons.warning_amber_rounded,
                    color: Colors.orange,
                    label: 'Pendiente',
                    value:
                        '\$${(orden.total - (orden.totalPagado ?? 0)).toStringAsFixed(2)}',
                  ),
                ),
                Expanded(
                  child: _cardValores(
                    icon: Icons.percent,
                    color: Colors.indigo,
                    label: '%',
                    value: ((orden.totalPagado ?? 0) * 100 / orden.total)
                        .toStringAsFixed(1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🟠 CHIP ESTADO
  Widget _chipEstado() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Text(
            'Parcial',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.arrow_forward_ios, size: 12, color: Colors.orange),
        ],
      ),
    );
  }

  // 📊 PROGRESS BAR
  Widget _barraProgresiva() {
    double pagado = orden.totalPagado ?? 0;
    double total = orden.total;
    double porcentaje = pagado / total;

    Color color = porcentaje <= 0.3
        ? Colors.red
        : porcentaje <= 0.7
        ? Colors.orange
        : Colors.green;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pagado: \$${pagado.toStringAsFixed(2)} de \$${total.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: porcentaje,
            minHeight: 10,
            backgroundColor: Colors.grey.shade300,
            color: color,
          ),
        ),
      ],
    );
  }

  // 💰 MINI CARD
  Widget _cardValores({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detallePagos() {
    return Container(margin: EdgeInsets.symmetric(horizontal: 10));
  }
}
