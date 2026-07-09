import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/order_model.dart';

class OrderRemoteDataSource {
  final ApiClient apiClient;

  OrderRemoteDataSource(this.apiClient);

  Future<List<OrderModel>> getMyOrders() async {
    try {
      final response = await apiClient.dio.get('${ApiConstants.orders}/mine');
      return (response.data as List)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<OrderModel> getOrderDetail(int id) async {
    try {
      final response = await apiClient.dio.get('${ApiConstants.orders}/$id');
      return OrderModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<void> cancelOrder(int id, String reason) async {
    try {
      await apiClient.dio.put(
        '${ApiConstants.orders}/$id/cancel',
        data: {'reason': reason},
      );
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
