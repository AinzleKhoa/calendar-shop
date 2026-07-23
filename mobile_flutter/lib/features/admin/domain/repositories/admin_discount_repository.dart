import '../entities/admin_discount.dart';

// Lớp AdminDiscountRepository giữ trách nhiệm chính của file này.
abstract class AdminDiscountRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<({List<AdminDiscount> items, int totalCount})> getDiscounts({
    String? searchQuery,
    int page = 1,
    int pageSize = 10,
    String? filterStatus,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    String? sortByDiscountValue,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminDiscount> getDiscountById(int id);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminDiscount> createDiscount({
    required String name,
    required String discountType,
    required double discountValue,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required String scope,
    required List<int> targetIds,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateDiscount(
    int id, {
    required String name,
    required String discountType,
    required double discountValue,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required String scope,
    required List<int> targetIds,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateDiscountStatus(int id, String status);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteDiscount(int id);
}
