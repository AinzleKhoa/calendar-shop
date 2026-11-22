import '../repositories/admin_coupon_repository.dart';

// Lớp UpdateAdminCouponUseCase giữ trách nhiệm chính của file này.
class UpdateAdminCouponUseCase {
  final AdminCouponRepository repository;

  UpdateAdminCouponUseCase(this.repository);

  Future<void> call(
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
  }) {
    return repository.updateCoupon(
      id,
      code: code,
      description: description,
      discountType: discountType,
      discountValue: discountValue,
      minOrderValue: minOrderValue,
      startDate: startDate,
      endDate: endDate,
      usageLimit: usageLimit,
      status: status,
    );
  }
}
