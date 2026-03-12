import 'package:ecommerce_prueba/src/domain/repository/OrderPaymentRepository.dart';

class GetOrderPaymentsByOrdenUseCase {
  OrderPaymentRepository orderPaymentRepository;
  GetOrderPaymentsByOrdenUseCase(this.orderPaymentRepository);
  run(String idOrden) => orderPaymentRepository.getOrderPaymentByOrden(idOrden);
}
