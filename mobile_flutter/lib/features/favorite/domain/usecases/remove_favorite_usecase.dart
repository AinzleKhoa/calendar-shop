import '../repositories/favorite_repository.dart';

// Lớp RemoveFavoriteUseCase giữ trách nhiệm chính của file này.
class RemoveFavoriteUseCase {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase(this.repository);

  Future<void> call(int productId) {
    return repository.removeFavorite(productId);
  }
}
