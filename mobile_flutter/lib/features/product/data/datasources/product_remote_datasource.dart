import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

// Lớp ProductRemoteDataSource giữ trách nhiệm chính của file này.
class ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<ProductModel>> getProducts({
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
    try {
      final List<String> filters = [];
      if (categoryId != null) {
        filters.add('CategoryId eq $categoryId');
      }
      if (search != null && search.isNotEmpty) {
        final escapedSearch = search.replaceAll("'", "''").toLowerCase();
        filters.add("contains(tolower(ProductName), '$escapedSearch')");
      }
      if (minPrice != null) {
        filters.add('Price ge $minPrice');
      }
      if (maxPrice != null) {
        filters.add('Price le $maxPrice');
      }
      if (calendarType != null && calendarType.isNotEmpty) {
        final escapedCalendarType = calendarType.replaceAll("'", "''");
        filters.add("CalendarType eq '$escapedCalendarType'");
      }

      final String? filterQuery =
          filters.isNotEmpty ? filters.join(' and ') : null;

      String? orderbyQuery;
      if (sort == 'price_asc') {
        orderbyQuery = 'Price asc';
      } else if (sort == 'price_desc') {
        orderbyQuery = 'Price desc';
      } else if (sort == 'newest') {
        orderbyQuery = 'CreatedAt desc';
      }

      final response =
          // Gọi API GET để lấy dữ liệu từ backend.
          await apiClient.dio.get(ApiConstants.products, queryParameters: {
        'includeHidden': includeHidden,
        if (filterQuery != null) '\$filter': filterQuery,
        if (orderbyQuery != null) '\$orderby': orderbyQuery,
        if (top != null) '\$top': top,
        if (skip != null) '\$skip': skip,
      });

      final List dataList;
      if (response.data is Map && (response.data as Map).containsKey('value')) {
        dataList = response.data['value'] as List;
      } else if (response.data is List) {
        dataList = response.data as List;
      } else {
        dataList = [];
      }

      // Parse JSON từ backend sang model Dart.
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<ProductModel> getProductById(int id) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.products}/$id');
      // Parse JSON từ backend sang model Dart.
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<ProductModel> createProduct({
    required int categoryId,
    required String productName,
    String? description,
    required double price,
    required int stockQuantity,
    String? imageUrl,
    required String calendarType,
    required String status,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(ApiConstants.products, data: {
        'categoryId': categoryId,
        'productName': productName,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'imageUrl': imageUrl,
        'calendarType': calendarType,
        'status': status,
      });
      // Parse JSON từ backend sang model Dart.
      return ProductModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

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
  }) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.products}/$id', data: {
        'categoryId': categoryId,
        'productName': productName,
        'description': description,
        'price': price,
        'stockQuantity': stockQuantity,
        'imageUrl': imageUrl,
        'calendarType': calendarType,
        'status': status,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteProduct(int id) async {
    try {
      // Gọi API DELETE để xóa dữ liệu trên backend.
      await apiClient.dio.delete('${ApiConstants.products}/$id');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
