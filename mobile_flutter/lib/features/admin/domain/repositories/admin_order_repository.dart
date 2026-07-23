import '../entities/admin_order.dart';

// Lớp AdminOrderRepository giữ trách nhiệm chính của file này.
abstract class AdminOrderRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AdminOrder>> getOrders({
    String? search,
    String? status,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminOrder> getOrderById(int id);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateOrderStatus(int id, String status, {String? note});
}
