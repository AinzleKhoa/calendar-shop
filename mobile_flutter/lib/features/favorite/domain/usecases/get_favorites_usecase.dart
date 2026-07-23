import '../entities/favorite.dart';
import '../repositories/favorite_repository.dart';

// Lớp GetFavoritesUseCase giữ trách nhiệm chính của file này.
class GetFavoritesUseCase {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<Favorite>> call() {
    return repository.getFavorites();
  }
}
