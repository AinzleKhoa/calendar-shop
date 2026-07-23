import '../entities/admin_user.dart';
import '../repositories/admin_user_repository.dart';

// Lớp GetAdminUserByIdUseCase giữ trách nhiệm chính của file này.
class GetAdminUserByIdUseCase {
  final AdminUserRepository repository;

  GetAdminUserByIdUseCase(this.repository);

  Future<AdminUser> call(int id) {
    return repository.getUserById(id);
  }
}
