import '../entities/product.dart';

// Lớp ProductRepository giữ trách nhiệm chính của file này.
abstract class ProductRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<Product>> getProducts({
    int? categoryId,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? calendarType,
    String sort,
    bool includeHidden = false,
    int? top,
    int? skip,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Product> getProductById(int id);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Product> createProduct({
    required int categoryId,
    required String productName,
    String? description,
    required double price,
    required int stockQuantity,
    String? imageUrl,
    required String calendarType,
    required String status,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateProduct(
    int id, {
    required int categoryId,
    required String productName,
    String? description,
    required double price,
    required int stockQuantity,
    String? imageUrl,
    required String calendarType,
    required String status,
  });

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteProduct(int id);
}
