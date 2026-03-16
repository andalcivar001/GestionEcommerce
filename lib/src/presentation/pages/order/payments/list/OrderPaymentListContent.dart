import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:flutter/material.dart';

class OrderPaymentListContent extends StatelessWidget {
  Order orden;
  OrderPaymentListContent({required this.orden, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: Stack(
                children: [
                  _cardPrincipal(),
                  _cardOrden(
                    chipEstado: _chipEstado(),
                    nombre: orden.cliente?.nombre ?? 'n/a',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Detalle de Pagos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPrincipal() {
    return Card(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Padding(padding: EdgeInsets.all(20)),
      ),
    );
  }

  Widget _cardOrden({required Widget chipEstado, required String nombre}) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Card(
        elevation: 2,

        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 5),
                              Text('#${orden.secuencia.toString()}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  chipEstado,
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey.shade300),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _cardValores(
                      icon: Icons.attach_money,
                      color: Colors.blue,
                      label: 'Total Venta',
                      value: '\$${orden.total.toStringAsFixed(2)}',
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: _cardValores(
                      icon: Icons.check,
                      color: Colors.green,
                      label: 'Total Pagado',
                      value: '\$50.00',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _cardValores(
                      icon: Icons.error_outline,
                      color: Colors.orange,
                      label: 'Total Venta',
                      value: '\$30.00',
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: _cardValores(
                      icon: Icons.percent,
                      color: Colors.teal,
                      label: '% Pagado',
                      value: '70.00',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chipEstado() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pago parcial',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Icon(Icons.arrow_forward_ios, size: 17, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _cardValores({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Card(
      elevation: 1,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
