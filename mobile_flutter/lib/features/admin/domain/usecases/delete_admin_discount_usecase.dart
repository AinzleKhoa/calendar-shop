import '../repositories/admin_discount_repository.dart';

// Lớp DeleteAdminDiscountUseCase giữ trách nhiệm chính của file này.
class DeleteAdminDiscountUseCase {
  final AdminDiscountRepository repository;

  DeleteAdminDiscountUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteDiscount(id);
  }
}
