import '../repositories/admin_discount_repository.dart';

// Lớp UpdateAdminDiscountUseCase giữ trách nhiệm chính của file này.
class UpdateAdminDiscountUseCase {
  final AdminDiscountRepository repository;

  UpdateAdminDiscountUseCase(this.repository);

  Future<void> call(
    int id, {
    required String name,
    required String discountType,
    required double discountValue,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required String scope,
    required List<int> targetIds,
  }) {
    return repository.updateDiscount(
      id,
      name: name,
      discountType: discountType,
      discountValue: discountValue,
      startDate: startDate,
      endDate: endDate,
      status: status,
      scope: scope,
      targetIds: targetIds,
    );
  }
}
