import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

abstract class OrderPaymentRepository {
  Future<Resource<List<OrderPayment>>> getOrderPaymentByOrden(String idOrden);
  Future<Resource<OrderPayment>> getOrderPaymentById(String id);
  Future<Resource<OrderPayment>> create(OrderPayment orderPayment);
  Future<Resource<OrderPayment>> update(OrderPayment orderPayment, String id);
  Future<Resource<bool>> delete(String id);
}
