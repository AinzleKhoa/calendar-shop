import '../entities/review.dart';
import '../repositories/review_repository.dart';

// Lớp GetProductReviewsUseCase giữ trách nhiệm chính của file này.
class GetProductReviewsUseCase {
  final ReviewRepository repository;

  GetProductReviewsUseCase(this.repository);

  Future<List<Review>> call(int productId) {
    return repository.getProductReviews(productId);
  }
}
