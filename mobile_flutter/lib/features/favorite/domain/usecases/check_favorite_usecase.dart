import '../repositories/favorite_repository.dart';

// Lớp CheckFavoriteUseCase giữ trách nhiệm chính của file này.
class CheckFavoriteUseCase {
  final FavoriteRepository repository;

  CheckFavoriteUseCase(this.repository);

  Future<bool> call(int productId) {
    return repository.checkFavorite(productId);
  }
}
