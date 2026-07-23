import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/favorite_model.dart';

// Lớp FavoriteRemoteDataSource giữ trách nhiệm chính của file này.
class FavoriteRemoteDataSource {
  final ApiClient apiClient;

  FavoriteRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<FavoriteModel>> getFavorites() async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(ApiConstants.favorites);
      final List dataList = response.data as List;
      // Parse JSON từ backend sang model Dart.
      return dataList.map((e) => FavoriteModel.fromJson(e)).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> addFavorite(int productId) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post(ApiConstants.favorites, data: {
        'productId': productId,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> removeFavorite(int productId) async {
    try {
      // Gọi API DELETE để xóa dữ liệu trên backend.
      await apiClient.dio.delete('${ApiConstants.favorites}/$productId');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<bool> checkFavorite(int productId) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.favorites}/check/$productId');
      return response.data as bool;
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
