import '../repositories/product_repository.dart';

// Lớp DeleteProductUseCase giữ trách nhiệm chính của file này.
class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteProduct(id);
  }
}
