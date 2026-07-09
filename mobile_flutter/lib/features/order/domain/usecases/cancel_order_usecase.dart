import '../repositories/order_repository.dart';

class CancelOrderUseCase {
  final OrderRepository repository;

  CancelOrderUseCase(this.repository);

  Future<void> call(int id, String reason) {
    return repository.cancelOrder(id, reason);
  }
}
