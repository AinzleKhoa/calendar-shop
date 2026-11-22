import '../repositories/admin_order_repository.dart';

// Lớp UpdateAdminOrderStatusUseCase giữ trách nhiệm chính của file này.
class UpdateAdminOrderStatusUseCase {
  final AdminOrderRepository repository;

  UpdateAdminOrderStatusUseCase(this.repository);

  Future<void> call(int id, String status, {String? note}) {
    return repository.updateOrderStatus(id, status, note: note);
  }
}
