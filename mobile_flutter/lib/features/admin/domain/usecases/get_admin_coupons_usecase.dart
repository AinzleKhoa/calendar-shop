import '../entities/admin_coupon.dart';
import '../repositories/admin_coupon_repository.dart';

// Lớp GetAdminCouponsUseCase giữ trách nhiệm chính của file này.
class GetAdminCouponsUseCase {
  final AdminCouponRepository repository;

  GetAdminCouponsUseCase(this.repository);

  Future<List<AdminCoupon>> call() {
    return repository.getCoupons();
  }
}
