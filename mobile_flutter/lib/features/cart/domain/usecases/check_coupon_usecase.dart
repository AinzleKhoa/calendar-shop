import '../entities/checked_coupon.dart';
import '../repositories/cart_repository.dart';

// Lớp CheckCouponUseCase giữ trách nhiệm chính của file này.
class CheckCouponUseCase {
  final CartRepository repository;

  const CheckCouponUseCase(this.repository);

  Future<CheckedCoupon> call(String code, double subTotal) {
    return repository.checkCoupon(code, subTotal);
  }
}
