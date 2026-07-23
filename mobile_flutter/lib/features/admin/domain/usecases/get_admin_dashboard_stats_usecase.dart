import '../entities/admin_dashboard_stats.dart';
import '../repositories/admin_dashboard_repository.dart';

// Lớp GetAdminDashboardStatsUseCase giữ trách nhiệm chính của file này.
class GetAdminDashboardStatsUseCase {
  final AdminDashboardRepository repository;

  GetAdminDashboardStatsUseCase(this.repository);

  Future<AdminDashboardStats> call([int days = 7]) {
    return repository.getDashboardStats(days);
  }
}
