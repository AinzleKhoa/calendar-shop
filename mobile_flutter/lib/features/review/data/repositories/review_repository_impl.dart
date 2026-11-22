import '../../domain/entities/review.dart';
import '../../domain/entities/product_rating_summary.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/review_remote_datasource.dart';
import '../models/review_model.dart';
import '../models/product_rating_summary_model.dart';

// Lớp ReviewRepositoryImpl giữ trách nhiệm chính của file này.
class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<Review>> getProductReviews(int productId) async {
    final models = await remoteDataSource.getProductReviews(productId);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((m) => m.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<ProductRatingSummary> getProductRatingSummary(int productId) async {
    final model = await remoteDataSource.getProductRatingSummary(productId);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> createReview(int orderItemId, int rating, String? comment) async {
    return remoteDataSource.createReview(orderItemId, rating, comment);
  }
}
