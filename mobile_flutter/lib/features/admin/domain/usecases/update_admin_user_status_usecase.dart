import '../repositories/admin_user_repository.dart';

// Lớp UpdateAdminUserStatusUseCase giữ trách nhiệm chính của file này.
class UpdateAdminUserStatusUseCase {
  final AdminUserRepository repository;

  UpdateAdminUserStatusUseCase(this.repository);

  Future<void> call({required int id, required String status}) {
    return repository.updateStatus(id: id, status: status);
  }
}
