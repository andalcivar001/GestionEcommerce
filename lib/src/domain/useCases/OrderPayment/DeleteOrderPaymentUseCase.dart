import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class DeleteOrderPaymentUseCase {
  OrderPaymentRepository orderPaymentRepository;
  DeleteOrderPaymentUseCase(this.orderPaymentRepository);
  run(String id) => orderPaymentRepository.delete(id);
}
