import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class CreateOrderPaymentUseCase {
  OrderPaymentRepository orderPaymentRepository;
  CreateOrderPaymentUseCase(this.orderPaymentRepository);
  run(OrderPayment orderPayment) => orderPaymentRepository.create(orderPayment);
}
