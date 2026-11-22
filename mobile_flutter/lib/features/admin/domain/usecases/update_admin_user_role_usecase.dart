import '../repositories/admin_user_repository.dart';

// Lớp UpdateAdminUserRoleUseCase giữ trách nhiệm chính của file này.
class UpdateAdminUserRoleUseCase {
  final AdminUserRepository repository;

  UpdateAdminUserRoleUseCase(this.repository);

  Future<void> call({required int id, required String role}) {
    return repository.updateRole(id: id, role: role);
  }
}
