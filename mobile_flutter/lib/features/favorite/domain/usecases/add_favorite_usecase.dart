import '../repositories/favorite_repository.dart';

// Lớp AddFavoriteUseCase giữ trách nhiệm chính của file này.
class AddFavoriteUseCase {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<void> call(int productId) {
    return repository.addFavorite(productId);
  }
}
