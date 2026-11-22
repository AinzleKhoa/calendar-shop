import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

// Lớp CategoryRepositoryImpl giữ trách nhiệm chính của file này.
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<Category>> getCategories() async {
    final models = await remoteDataSource.getCategories();
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((m) => m.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<Category> createCategory(String name, String? description, String status) async {
    final model = await remoteDataSource.createCategory(name, description, status);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> updateCategory(int id, String name, String? description, String status) async {
    return remoteDataSource.updateCategory(id, name, description, status);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> deleteCategory(int id) async {
    return remoteDataSource.deleteCategory(id);
  }
}
