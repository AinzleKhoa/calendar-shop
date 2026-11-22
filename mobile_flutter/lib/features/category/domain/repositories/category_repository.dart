import '../entities/category.dart';

// Lớp CategoryRepository giữ trách nhiệm chính của file này.
abstract class CategoryRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<Category>> getCategories();
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Category> createCategory(String name, String? description, String status);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateCategory(int id, String name, String? description, String status);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteCategory(int id);
}
