import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/admin_order_model.dart';

// Lớp AdminOrderRemoteDataSource giữ trách nhiệm chính của file này.
class AdminOrderRemoteDataSource {
  final ApiClient apiClient;

  AdminOrderRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AdminOrderModel>> getOrders({
    String? search,
    String? status,
  }) async {
    final List<String> filters = [];
    if (search != null && search.isNotEmpty) {
      final escapedSearch = search.replaceAll("'", "''").toLowerCase();
      filters.add("(contains(tolower(CustomerName), '$escapedSearch') or contains(CustomerPhone, '$escapedSearch'))");
    }
    if (status != null && status.isNotEmpty && status != 'All') {
      filters.add("Status eq '$status'");
    }

    final String? filterQuery = filters.isNotEmpty ? filters.join(' and ') : null;

    // Gọi API GET để lấy dữ liệu từ backend.
    final response = await apiClient.dio.get('${ApiConstants.orders}/admin', queryParameters: {
      if (filterQuery != null) '\$filter': filterQuery,
      '\$orderby': 'CreatedAt desc',
    });

    final List dataList;
    if (response.data is Map && (response.data as Map).containsKey('value')) {
      dataList = response.data['value'] as List;
    } else if (response.data is List) {
      dataList = response.data as List;
    } else {
      dataList = [];
    }

    // Parse JSON từ backend sang model Dart.
    return dataList.map((e) => AdminOrderModel.fromJson(e)).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateOrderStatus(int id, String status, {String? note}) async {
    // Gọi API PUT để cập nhật dữ liệu trên backend.
    await apiClient.dio.put('${ApiConstants.orders}/admin/$id/status', data: {
      'status': status,
      'note': note,
    });
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminOrderModel> getOrderById(int id) async {
    // Gọi API GET để lấy dữ liệu từ backend.
    final response = await apiClient.dio.get('${ApiConstants.orders}/admin', queryParameters: {
      '\$filter': 'OrderId eq $id',
    });

    final List dataList;
    if (response.data is Map && (response.data as Map).containsKey('value')) {
      dataList = response.data['value'] as List;
    } else if (response.data is List) {
      dataList = response.data as List;
    } else {
      dataList = [];
    }

    if (dataList.isEmpty) {
      throw Exception('Không tìm thấy đơn hàng');
    }
    // Parse JSON từ backend sang model Dart.
    return AdminOrderModel.fromJson(dataList.first);
  }
}
