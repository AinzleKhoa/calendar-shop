import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/admin_dashboard_stats_model.dart';

// Lớp AdminDashboardRemoteDataSource giữ trách nhiệm chính của file này.
class AdminDashboardRemoteDataSource {
  final ApiClient apiClient;

  AdminDashboardRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminDashboardStatsModel> getDashboardStats([int days = 7]) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.adminDashboard}?days=$days');
      // Parse JSON từ backend sang model Dart.
      return AdminDashboardStatsModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<int>> exportRevenueExcel() async {
    try {
      final response = await apiClient.dio.get<List<int>>(
        '${ApiConstants.adminDashboard}/export-revenue',
        options: Options(responseType: ResponseType.bytes),
      );
      return response.data ?? <int>[];
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
