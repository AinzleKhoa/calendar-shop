import '../entities/product.dart';
import '../repositories/product_repository.dart';

// Lớp GetProductByIdUseCase giữ trách nhiệm chính của file này.
class GetProductByIdUseCase {
  final ProductRepository repository;

  GetProductByIdUseCase(this.repository);

  Future<Product> call(int id) {
    return repository.getProductById(id);
  }
}
