import '../entities/review.dart';
import '../entities/product_rating_summary.dart';

// Lớp ReviewRepository giữ trách nhiệm chính của file này.
abstract class ReviewRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<Review>> getProductReviews(int productId);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<ProductRatingSummary> getProductRatingSummary(int productId);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> createReview(int orderItemId, int rating, String? comment);
}
