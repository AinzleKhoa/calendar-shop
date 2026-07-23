import '../../domain/entities/favorite.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_remote_datasource.dart';
import '../models/favorite_model.dart';

// Lớp FavoriteRepositoryImpl giữ trách nhiệm chính của file này.
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<Favorite>> getFavorites() async {
    final models = await remoteDataSource.getFavorites();
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((m) => m.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> addFavorite(int productId) async {
    return remoteDataSource.addFavorite(productId);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> removeFavorite(int productId) async {
    return remoteDataSource.removeFavorite(productId);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<bool> checkFavorite(int productId) async {
    return remoteDataSource.checkFavorite(productId);
  }
}
