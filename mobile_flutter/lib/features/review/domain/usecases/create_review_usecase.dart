import '../repositories/review_repository.dart';

// Lớp CreateReviewUseCase giữ trách nhiệm chính của file này.
class CreateReviewUseCase {
  final ReviewRepository repository;

  CreateReviewUseCase(this.repository);

  Future<void> call(int orderItemId, int rating, String? comment) {
    return repository.createReview(orderItemId, rating, comment);
  }
}
