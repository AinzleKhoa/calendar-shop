import '../../domain/entities/admin_dashboard_stats.dart';
import '../../domain/repositories/admin_dashboard_repository.dart';
import '../datasources/admin_dashboard_remote_datasource.dart';
import '../models/admin_dashboard_stats_model.dart';

// Lớp AdminDashboardRepositoryImpl giữ trách nhiệm chính của file này.
class AdminDashboardRepositoryImpl implements AdminDashboardRepository {
  final AdminDashboardRemoteDataSource remoteDataSource;

  AdminDashboardRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<AdminDashboardStats> getDashboardStats([int days = 7]) async {
    final model = await remoteDataSource.getDashboardStats(days);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<int>> exportRevenueExcel() {
    return remoteDataSource.exportRevenueExcel();
  }
}
