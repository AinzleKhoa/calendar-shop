import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/admin_discount_model.dart';

// Lớp AdminDiscountRemoteDataSource giữ trách nhiệm chính của file này.
class AdminDiscountRemoteDataSource {
  final ApiClient apiClient;

  AdminDiscountRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<({List<AdminDiscountModel> items, int totalCount})> getDiscounts({
    String? searchQuery,
    int page = 1,
    int pageSize = 10,
    String? filterStatus,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    String? sortByDiscountValue,
  }) async {
    List<String> queryParams = [];
    queryParams.add('\$count=true');
    queryParams.add('\$skip=${(page - 1) * pageSize}');
    queryParams.add('\$top=$pageSize');
    
    List<String> filterConditions = [];
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filterConditions.add('contains(tolower(Name), \'${searchQuery.toLowerCase()}\')');
    }
    if (filterStatus != null && filterStatus != 'All') {
      filterConditions.add('Status eq \'$filterStatus\'');
    }
    if (filterStartDate != null) {
      filterConditions.add('StartDate ge ${filterStartDate.toUtc().toIso8601String()}');
    }
    if (filterEndDate != null) {
      filterConditions.add('EndDate le ${filterEndDate.toUtc().toIso8601String()}');
    }

    if (filterConditions.isNotEmpty) {
      queryParams.add('\$filter=${filterConditions.join(' and ')}');
    }

    List<String> orderBys = [];
    if (sortByDiscountValue != null && sortByDiscountValue.isNotEmpty) orderBys.add('DiscountValue $sortByDiscountValue');
    
    if (orderBys.isNotEmpty) {
      queryParams.add('\$orderby=${orderBys.join(', ')}');
    }

    final url = '${ApiConstants.discounts}?${queryParams.join('&')}';
    // Gọi API GET để lấy dữ liệu từ backend.
    final response = await apiClient.dio.get(url);
    
    final List data;
    int totalCount = 0;
    
    if (response.data is Map) {
      final mapData = response.data as Map;
      if (mapData.containsKey('value')) {
        data = mapData['value'] as List;
      } else {
        data = [];
      }
      if (mapData.containsKey('@odata.count')) {
        totalCount = mapData['@odata.count'] as int;
      }
    } else if (response.data is List) {
      data = response.data as List;
      totalCount = data.length;
    } else {
      data = [];
    }
    
    // Parse JSON từ backend sang model Dart.
    final items = data.map((e) => AdminDiscountModel.fromJson(e)).toList();
    return (items: items, totalCount: totalCount);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminDiscountModel> getDiscountById(int id) async {
    // Gọi API GET để lấy dữ liệu từ backend.
    final response = await apiClient.dio.get('${ApiConstants.discounts}/$id');
    // Parse JSON từ backend sang model Dart.
    return AdminDiscountModel.fromJson(response.data);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminDiscountModel> createDiscount(Map<String, dynamic> data) async {
    // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
    final response = await apiClient.dio.post(ApiConstants.discounts, data: data);
    // Parse JSON từ backend sang model Dart.
    return AdminDiscountModel.fromJson(response.data);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateDiscount(int id, Map<String, dynamic> data) async {
    // Gọi API PUT để cập nhật dữ liệu trên backend.
    await apiClient.dio.put('${ApiConstants.discounts}/$id', data: data);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteDiscount(int id) async {
    // Gọi API DELETE để xóa dữ liệu trên backend.
    await apiClient.dio.delete('${ApiConstants.discounts}/$id');
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateDiscountStatus(int id, String status) async {
    // Gọi API PUT để cập nhật dữ liệu trên backend.
    await apiClient.dio.put('${ApiConstants.discounts}/$id/status', data: {'status': status});
  }
}
