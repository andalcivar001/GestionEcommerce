import 'package:ecommerce_prueba/src/data/datasource/remote/OrderPaymentService.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';

class OrderPaymentRepositoryImpl extends OrderPaymentRepository {
  OrderPaymentService orderPaymentService;
  OrderPaymentRepositoryImpl(this.orderPaymentService);

  @override
  Future<Resource<OrderPayment>> create(OrderPayment orderPayment) async {
    return await orderPaymentService.create(orderPayment);
  }

  @override
  Future<Resource<bool>> delete(String id) async {
    return await orderPaymentService.delete(id);
  }

  @override
  Future<Resource<OrderPayment>> getOrderPaymentById(String id) async {
    return await orderPaymentService.getOrderPaymentById(id);
  }

  @override
  Future<Resource<List<OrderPayment>>> getOrderPaymentByOrden(
    String idOrden,
  ) async {
    return await orderPaymentService.getOrderPaymentByOrden(idOrden);
  }

  @override
  Future<Resource<OrderPayment>> update(
    OrderPayment orderPayment,
    String id,
  ) async {
    return await orderPaymentService.update(orderPayment, id);
  }
}
