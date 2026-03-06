import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart' as ord;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/*
/*** FONTSIZE RECOMENDADOS PARA IMPRESIONES ****/
Uso	FontSize recomendado
Título	14–16
Subtítulo	11–12
Productos	7–9
Totales	9–11
*************************/

@injectable
class PdfOrderService {
  Future<Uint8List> generaVenta(ord.Order orden) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        //Impresoras térmicas de 80mm
        pageFormat: PdfPageFormat.roll80,
        margin: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'MI TIENDA',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Center(
                child: pw.Text(
                  'Victor Hugo Briones y Sucre',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Center(
                child: pw.Text(
                  'Telf: 0982215699',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 2),
              pw.Center(
                child: pw.Text(
                  'Venta N° ${orden.secuencia}',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),

              pw.SizedBox(height: 8),
              pw.Text(
                'Fecha: ${DateFormat('yyyy-MM-dd HH:mm').format(orden.fecha)}',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                'Cliente: ${orden.cliente!.nombre}',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 15),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Prod.', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('Cant.', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('P. U.', style: pw.TextStyle(fontSize: 10)),
                  pw.Text('P. T.', style: pw.TextStyle(fontSize: 10)),
                ],
              ),
              pw.Divider(),
              ...orden.detalles.map((detalle) {
                final totalLinea = detalle.cantidad * detalle.precio;

                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(
                      width: 95,
                      child: pw.Text(
                        detalle.producto!.descripcion,
                        maxLines: 2,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),

                    pw.SizedBox(
                      width: 25,
                      child: pw.Text(
                        detalle.cantidad.toString(),
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),

                    pw.SizedBox(
                      width: 35,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '\$${detalle.precio.toStringAsFixed(2)}',
                          style: pw.TextStyle(fontSize: 8),
                        ),
                      ),
                    ),

                    pw.SizedBox(
                      width: 40,
                      child: pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          '\$${totalLinea.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Subtotal:'),
                  pw.Text(
                    '\$${orden.subtotal.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Impuestos:', textAlign: pw.TextAlign.end),
                  pw.Text(
                    '\$${orden.impuestos.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total:'),
                  pw.Text(
                    '\$${orden.total.toStringAsFixed(2)}',
                    textAlign: pw.TextAlign.end,
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
