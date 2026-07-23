import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/category_model.dart';

// Lớp CategoryRemoteDataSource giữ trách nhiệm chính của file này.
class CategoryRemoteDataSource {
  final ApiClient apiClient;

  CategoryRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<CategoryModel>> getCategories() async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(ApiConstants.categories);
      final List dataList;
      if (response.data is Map && (response.data as Map).containsKey('value')) {
        dataList = response.data['value'] as List;
      } else if (response.data is List) {
        dataList = response.data as List;
      } else {
        dataList = [];
      }
      // Parse JSON từ backend sang model Dart.
      return dataList.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<CategoryModel> createCategory(String name, String? description, String status) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(ApiConstants.categories, data: {
        'categoryName': name,
        'description': description,
        'status': status,
      });
      // Parse JSON từ backend sang model Dart.
      return CategoryModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> updateCategory(int id, String name, String? description, String status) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.categories}/$id', data: {
        'categoryName': name,
        'description': description,
        'status': status,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteCategory(int id) async {
    try {
      // Gọi API DELETE để xóa dữ liệu trên backend.
      await apiClient.dio.delete('${ApiConstants.categories}/$id');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
