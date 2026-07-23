import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/review_model.dart';
import '../models/product_rating_summary_model.dart';

// Lớp ReviewRemoteDataSource giữ trách nhiệm chính của file này.
class ReviewRemoteDataSource {
  final ApiClient apiClient;

  ReviewRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<ReviewModel>> getProductReviews(int productId) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.reviews}/product/$productId');
      final List dataList = response.data as List;
      // Parse JSON từ backend sang model Dart.
      return dataList.map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<ProductRatingSummaryModel> getProductRatingSummary(int productId) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.reviews}/product/$productId/summary');
      // Parse JSON từ backend sang model Dart.
      return ProductRatingSummaryModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> createReview(int orderItemId, int rating, String? comment) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post(ApiConstants.reviews, data: {
        'orderItemId': orderItemId,
        'rating': rating,
        'comment': comment,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
