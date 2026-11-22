import '../repositories/admin_dashboard_repository.dart';

// Lớp ExportRevenueExcelUseCase giữ trách nhiệm chính của file này.
class ExportRevenueExcelUseCase {
  final AdminDashboardRepository repository;

  ExportRevenueExcelUseCase(this.repository);

  Future<List<int>> call() {
    return repository.exportRevenueExcel();
  }
}
