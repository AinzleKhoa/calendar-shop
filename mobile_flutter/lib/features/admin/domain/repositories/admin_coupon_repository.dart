import '../entities/admin_coupon.dart';

// Lớp AdminCouponRepository giữ trách nhiệm chính của file này.
abstract class AdminCouponRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AdminCoupon>> getCoupons();

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminCoupon> getCouponById(int id);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AdminCoupon> createCoupon({
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required String status,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateCoupon(
    int id, {
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required String status,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateCouponStatus(int id, String status);
}
