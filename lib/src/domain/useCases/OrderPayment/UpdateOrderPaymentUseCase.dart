import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class UpdateOrderPaymentUseCase {
  OrderPaymentRepository orderPaymentRepository;
  UpdateOrderPaymentUseCase(this.orderPaymentRepository);
  run(OrderPayment orderPayment, String id) =>
      orderPaymentRepository.update(orderPayment, id);
}
