import '../entities/admin_coupon.dart';
import '../repositories/admin_coupon_repository.dart';

// Lớp GetAdminCouponByIdUseCase giữ trách nhiệm chính của file này.
class GetAdminCouponByIdUseCase {
  final AdminCouponRepository repository;

  GetAdminCouponByIdUseCase(this.repository);

  Future<AdminCoupon> call(int id) {
    return repository.getCouponById(id);
  }
}
