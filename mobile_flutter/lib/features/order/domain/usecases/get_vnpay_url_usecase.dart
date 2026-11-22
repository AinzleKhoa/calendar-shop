import '../repositories/order_repository.dart';

// Lớp GetVNPayUrlUseCase giữ trách nhiệm chính của file này.
class GetVNPayUrlUseCase {
  final OrderRepository repository;

  GetVNPayUrlUseCase(this.repository);

  Future<String> call(int orderId) {
    return repository.getVNPayUrl(orderId);
  }
}
