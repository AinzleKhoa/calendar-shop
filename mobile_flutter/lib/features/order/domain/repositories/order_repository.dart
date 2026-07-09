import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getMyOrders();

  Future<OrderEntity> getOrderDetail(int id);

  Future<void> cancelOrder(int id, String reason);
}
