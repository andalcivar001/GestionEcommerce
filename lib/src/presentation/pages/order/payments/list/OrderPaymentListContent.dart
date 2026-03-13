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
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(14),
              ),
              child: Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Column(children: []),
                  ),
                ),
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
          Expanded(
            child: Text(
              'Detalle de Pagos',
              textAlign: TextAlign.center,
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
}
