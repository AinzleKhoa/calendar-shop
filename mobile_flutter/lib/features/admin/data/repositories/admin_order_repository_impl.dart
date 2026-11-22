import '../../../../core/network/api_client.dart';
import '../../domain/entities/admin_order.dart';
import '../../domain/repositories/admin_order_repository.dart';
import '../datasources/admin_order_remote_datasource.dart';
import '../models/admin_order_model.dart';

// Lớp AdminOrderRepositoryImpl giữ trách nhiệm chính của file này.
class AdminOrderRepositoryImpl implements AdminOrderRepository {
  final AdminOrderRemoteDataSource remoteDataSource;
  final ApiClient apiClient;

  AdminOrderRepositoryImpl({
    required this.remoteDataSource,
    required this.apiClient,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<AdminOrder>> getOrders({
    String? search,
    String? status,
  }) async {
    try {
      final models = await remoteDataSource.getOrders(search: search, status: status);
      // Chuyển model DTO sang entity domain trước khi đưa lên UI.
      return models.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<AdminOrder> getOrderById(int id) async {
    try {
      final model = await remoteDataSource.getOrderById(id);
      // Chuyển model DTO sang entity domain trước khi đưa lên UI.
      return model.toEntity();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> updateOrderStatus(int id, String status, {String? note}) async {
    try {
      await remoteDataSource.updateOrderStatus(id, status, note: note);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
