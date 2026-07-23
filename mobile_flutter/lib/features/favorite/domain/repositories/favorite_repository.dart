import '../entities/favorite.dart';

// Lớp FavoriteRepository giữ trách nhiệm chính của file này.
abstract class FavoriteRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<Favorite>> getFavorites();
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> addFavorite(int productId);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> removeFavorite(int productId);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<bool> checkFavorite(int productId);
}
