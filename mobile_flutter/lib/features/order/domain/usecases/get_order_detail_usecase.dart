import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderDetailUseCase {
  final OrderRepository repository;

  GetOrderDetailUseCase(this.repository);

  Future<OrderEntity> call(int id) {
    return repository.getOrderDetail(id);
  }
}
