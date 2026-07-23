import '../entities/admin_order.dart';
import '../repositories/admin_order_repository.dart';

// Lớp GetAdminOrdersUseCase giữ trách nhiệm chính của file này.
class GetAdminOrdersUseCase {
  final AdminOrderRepository repository;

  GetAdminOrdersUseCase(this.repository);

  Future<List<AdminOrder>> call({String? search, String? status}) {
    return repository.getOrders(search: search, status: status);
  }
}
