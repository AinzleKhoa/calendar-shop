import '../entities/admin_user.dart';

// Lớp AdminUserRepository giữ trách nhiệm chính của file này.
abstract class AdminUserRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AdminUser>> getUsers({
    String? search,
    String? role,
    String? status,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminUser> getUserById(int id);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateStatus({required int id, required String status});
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateRole({required int id, required String role});
}
