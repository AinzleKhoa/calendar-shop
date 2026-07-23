import '../../domain/entities/admin_user.dart';
import '../../domain/repositories/admin_user_repository.dart';
import '../datasources/admin_user_remote_datasource.dart';
import '../models/admin_user_model.dart';

// Lớp AdminUserRepositoryImpl giữ trách nhiệm chính của file này.
class AdminUserRepositoryImpl implements AdminUserRepository {
  final AdminUserRemoteDataSource remoteDataSource;

  AdminUserRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<AdminUser>> getUsers({
    String? search,
    String? role,
    String? status,
  }) async {
    final models = await remoteDataSource.getUsers(
      search: search,
      role: role,
      status: status,
    );
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((model) => model.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<AdminUser> getUserById(int id) async {
    final model = await remoteDataSource.getUserById(id);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> updateRole({required int id, required String role}) {
    return remoteDataSource.updateRole(id: id, role: role);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> updateStatus({required int id, required String status}) {
    return remoteDataSource.updateStatus(id: id, status: status);
  }
}
