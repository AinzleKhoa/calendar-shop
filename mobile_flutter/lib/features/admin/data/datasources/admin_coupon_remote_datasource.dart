import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/admin_coupon_model.dart';

// Lớp AdminCouponRemoteDataSource giữ trách nhiệm chính của file này.
class AdminCouponRemoteDataSource {
  final ApiClient apiClient;

  AdminCouponRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AdminCouponModel>> getCoupons() async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(
        ApiConstants.coupons,
        queryParameters: {
          '\$orderby': 'CreatedAt desc',
        },
      );

      final List dataList;
      if (response.data is Map && (response.data as Map).containsKey('value')) {
        dataList = response.data['value'] as List;
      } else if (response.data is List) {
        dataList = response.data as List;
      } else {
        dataList = [];
      }

      // Parse JSON từ backend sang model Dart.
      return dataList.map((e) => AdminCouponModel.fromJson(e)).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminCouponModel> getCouponById(int id) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.coupons}/$id');
      // Parse JSON từ backend sang model Dart.
      return AdminCouponModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminCouponModel> createCoupon({
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required String status,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.coupons,
        data: {
          'code': code,
          'description': description,
          'discountType': discountType,
          'discountValue': discountValue,
          'minOrderValue': minOrderValue,
          'startDate': startDate.toUtc().toIso8601String(),
          'endDate': endDate.toUtc().toIso8601String(),
          'usageLimit': usageLimit,
          'status': status,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return AdminCouponModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateCoupon(
    int id, {
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required String status,
  }) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put(
        '${ApiConstants.coupons}/$id',
        data: {
          'code': code,
          'description': description,
          'discountType': discountType,
          'discountValue': discountValue,
          'minOrderValue': minOrderValue,
          'startDate': startDate.toUtc().toIso8601String(),
          'endDate': endDate.toUtc().toIso8601String(),
          'usageLimit': usageLimit,
          'status': status,
        },
      );
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateCouponStatus(int id, String status) async {
    try {
      await apiClient.dio.patch(
        '${ApiConstants.coupons}/$id/status',
        data: {
          'status': status,
        },
      );
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
