import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/admin_user_model.dart';

// Lớp AdminUserRemoteDataSource giữ trách nhiệm chính của file này.
class AdminUserRemoteDataSource {
  final ApiClient apiClient;

  AdminUserRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AdminUserModel>> getUsers({String? search, String? role, String? status}) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(ApiConstants.users, queryParameters: {
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
        if (role != null && role.trim().isNotEmpty) 'role': role.trim(),
        if (status != null && status.trim().isNotEmpty) 'status': status.trim(),
      });
      final data = response.data;
      final list = data is Map && data['value'] is List ? data['value'] as List : data as List;
      // Parse JSON từ backend sang model Dart.
      return list.map((e) => AdminUserModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminUserModel> getUserById(int id) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.users}/$id');
      // Parse JSON từ backend sang model Dart.
      return AdminUserModel.fromJson(Map<String, dynamic>.from(response.data as Map));
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateStatus({required int id, required String status}) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.users}/$id/status', data: {'status': status});
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateRole({required int id, required String role}) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.users}/$id/role', data: {'role': role});
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
