import '../entities/admin_dashboard_stats.dart';

// Lớp AdminDashboardRepository giữ trách nhiệm chính của file này.
abstract class AdminDashboardRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminDashboardStats> getDashboardStats([int days = 7]);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<int>> exportRevenueExcel();
}
