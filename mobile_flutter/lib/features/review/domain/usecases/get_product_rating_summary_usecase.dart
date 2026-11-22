import '../entities/product_rating_summary.dart';
import '../repositories/review_repository.dart';

// Lớp GetProductRatingSummaryUseCase giữ trách nhiệm chính của file này.
class GetProductRatingSummaryUseCase {
  final ReviewRepository repository;

  GetProductRatingSummaryUseCase(this.repository);

  Future<ProductRatingSummary> call(int productId) {
    return repository.getProductRatingSummary(productId);
  }
}
