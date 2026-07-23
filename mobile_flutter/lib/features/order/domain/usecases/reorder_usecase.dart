import '../repositories/order_repository.dart';

// Lớp ReorderUseCase giữ trách nhiệm chính của file này.
class ReorderUseCase {
  final OrderRepository repository;

  ReorderUseCase(this.repository);

  Future<void> call(int orderId) {
    return repository.reorder(orderId);
  }
}
