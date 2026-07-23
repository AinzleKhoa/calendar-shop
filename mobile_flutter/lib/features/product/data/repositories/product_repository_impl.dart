import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

// Lớp ProductRepositoryImpl giữ trách nhiệm chính của file này.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<Product>> getProducts({
    int? categoryId,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? calendarType,
    String sort = 'newest',
    bool includeHidden = false,
    int? top,
    int? skip,
  }) async {
    final models = await remoteDataSource.getProducts(
      categoryId: categoryId,
      search: search,
      minPrice: minPrice,
      maxPrice: maxPrice,
      calendarType: calendarType,
      sort: sort,
      includeHidden: includeHidden,
      top: top,
      skip: skip,
    );
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((m) => m.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<Product> getProductById(int id) async {
    final model = await remoteDataSource.getProductById(id);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<Product> createProduct({
    required int categoryId,
    required String productName,
    String? description,
    required double price,
    required int stockQuantity,
    String? imageUrl,
    required String calendarType,
    required String status,
  }) async {
    final model = await remoteDataSource.createProduct(
      categoryId: categoryId,
      productName: productName,
      description: description,
      price: price,
      stockQuantity: stockQuantity,
      imageUrl: imageUrl,
      calendarType: calendarType,
      status: status,
    );
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
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
  }) {
    return remoteDataSource.updateProduct(
      id,
      categoryId: categoryId,
      productName: productName,
      description: description,
      price: price,
      stockQuantity: stockQuantity,
      imageUrl: imageUrl,
      calendarType: calendarType,
      status: status,
    );
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> deleteProduct(int id) {
    return remoteDataSource.deleteProduct(id);
  }
}
