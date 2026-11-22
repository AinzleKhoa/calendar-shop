import '../../domain/entities/order.dart';
import '../../domain/entities/create_order_input.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/order_model.dart';
import '../models/create_order_request.dart';

/// Lớp triển khai (implementation) của OrderRepository ở tầng Domain.
/// Chịu trách nhiệm gọi nguồn dữ liệu (Data Source) và chuyển đổi Model DTO thành Entity sạch.
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<OrderEntity>> getMyOrders() async {
    // 1. Gọi remote datasource để lấy danh sách DTO models
    final models = await remoteDataSource.getMyOrders();

    // 2. Map từng Model DTO thô thành Entity sạch để UI sử dụng
    return models.map((model) => model.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<OrderEntity> getOrderById(int id) async {
    final model = await remoteDataSource.getOrderById(id);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> cancelOrder(int id, String? reason) {
    return remoteDataSource.cancelOrder(id, reason);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<OrderEntity> createOrder(CreateOrderInput input) async {
    final request = CreateOrderRequest(
      customerName: input.customerName,
      customerPhone: input.customerPhone,
      shippingAddress: input.shippingAddress,
      paymentMethod: input.paymentMethod,
      couponCode: input.couponCode,
      note: input.note,
    );
    final model = await remoteDataSource.createOrder(request);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<String> getVNPayUrl(int orderId) {
    return remoteDataSource.getVNPayUrl(orderId);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> reorder(int orderId) {
    return remoteDataSource.reorder(orderId);
  }
}
