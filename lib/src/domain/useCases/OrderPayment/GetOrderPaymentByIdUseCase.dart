import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class GetOrderPaymentByIdUseCase {
  OrderPaymentRepository orderPaymentRepository;
  GetOrderPaymentByIdUseCase(this.orderPaymentRepository);
  run(String id) => orderPaymentRepository.getOrderPaymentById(id);
}
