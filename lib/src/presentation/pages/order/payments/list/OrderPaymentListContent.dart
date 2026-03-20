import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPaymentListContent extends StatelessWidget {
  final Order orden;
  final List<OrderPayment> listaPagos;

  const OrderPaymentListContent({
    required this.orden,
    required this.listaPagos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    orden.totalPagado = 90.5;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _header(context),

            Padding(padding: const EdgeInsets.all(16), child: _cardOrden()),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Movimientos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Expanded(child: _detallePagos()),
          ],
        ),
      ),
    );
  }

  // 🔷 HEADER MODERNO

  Widget _header(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xff2F5DFF), // 🔵 azul elegante (no chillón)
      ),
      child: Row(
        children: [
          // 🔙 BACK
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 📝 TITLE
          const Text(
            'Pagos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          // ➕ ADD BUTTON
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.add, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // 💳 CARD PRINCIPAL (MEJORADA)
  Widget _cardOrden() {
    String nombre = orden.cliente?.nombre ?? 'Cliente';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // HEADER
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4A6CF7), Color(0xff6A8DFF)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Venta #${orden.secuencia}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              _chipEstado(),
            ],
          ),

          const SizedBox(height: 20),

          _barraProgresiva(),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _cardValores(
                  label: 'Total',
                  value: '\$${orden.total.toStringAsFixed(2)}',
                  color: Colors.blue,
                  icon: Icons.attach_money,
                ),
              ),
              Expanded(
                child: _cardValores(
                  label: 'Pagado',
                  value: '\$${(orden.totalPagado ?? 0).toStringAsFixed(2)}',
                  color: Colors.green,
                  icon: Icons.check,
                ),
              ),
              Expanded(
                child: _cardValores(
                  label: 'Pendiente',
                  value:
                      '\$${(orden.total - (orden.totalPagado ?? 0)).toStringAsFixed(2)}',
                  color: Colors.orange,
                  icon: Icons.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🟠 CHIP
  Widget _chipEstado() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Parcial',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  // 📊 PROGRESS BAR MÁS PRO
  Widget _barraProgresiva() {
    double pagado = orden.totalPagado ?? 0;
    double total = orden.total;
    double porcentaje = pagado / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${(porcentaje * 100).toStringAsFixed(0)}% pagado',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: porcentaje,
            minHeight: 12,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(Color(0xff4A6CF7)),
          ),
        ),
      ],
    );
  }

  // 💰 MINI CARD ELEGANTE
  Widget _cardValores({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withOpacity(0.08),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 💳 LISTA DE PAGOS MÁS LIMPIA
  Widget _detallePagos() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      itemCount: listaPagos.length,
      itemBuilder: (_, index) {
        final pago = listaPagos[index];
        IconData icon;
        switch (pago.metodoPago!.tipoPago) {
          case 'E':
            icon = Icons.monetization_on_outlined;
            break;
          case 'B':
            icon = Icons.account_balance;
            break;
          default:
            icon = Icons.credit_card;
            break;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffEEF2FF),
                child: Icon(icon, color: Color(0xff4A6CF7)),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pago.entidadFinanciera?.nombre ?? 'Efectivo',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      pago.referencia ?? '',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${pago.monto.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(orden.fecha),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
