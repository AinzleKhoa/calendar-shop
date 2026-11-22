import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';

@freezed
// Lớp Favorite giữ trách nhiệm chính của file này.
class Favorite with _$Favorite {
  const factory Favorite({
    required int favoriteId,
    required int productId,
    required String productName,
    String? imageUrl,
    required double price,
    required String calendarType,
    required String productStatus,
    required DateTime createdAt,
  }) = _Favorite;
}
