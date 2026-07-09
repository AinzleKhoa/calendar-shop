import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderEntity>> getMyOrders() async {
    final models = await remoteDataSource.getMyOrders();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<OrderEntity> getOrderDetail(int id) async {
    final model = await remoteDataSource.getOrderDetail(id);
    return model.toEntity();
  }

  @override
  Future<void> cancelOrder(int id, String reason) async {
    await remoteDataSource.cancelOrder(id, reason);
  }
}
