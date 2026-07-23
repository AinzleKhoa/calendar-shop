import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/review.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
// Lớp ReviewModel giữ trách nhiệm chính của file này.
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required int reviewId,
    required int userId,
    required String userFullName,
    String? userAvatarUrl,
    required int productId,
    required String productName,
    required int orderItemId,
    required int rating,
    String? comment,
    required String status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ReviewModel;

  // Parse JSON từ backend sang model Dart.
  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

extension ReviewModelMapper on ReviewModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  Review toEntity() => Review(
        reviewId: reviewId,
        userId: userId,
        userFullName: userFullName,
        userAvatarUrl: userAvatarUrl,
        productId: productId,
        productName: productName,
        orderItemId: orderItemId,
        rating: rating,
        comment: comment,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
