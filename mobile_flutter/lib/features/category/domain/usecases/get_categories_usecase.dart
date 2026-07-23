import '../entities/category.dart';
import '../repositories/category_repository.dart';

// Lớp GetCategoriesUseCase giữ trách nhiệm chính của file này.
class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<Category>> call() {
    return repository.getCategories();
  }
}
