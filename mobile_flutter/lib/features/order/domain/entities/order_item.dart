import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item.freezed.dart';

@freezed
// Lớp OrderItemEntity giữ trách nhiệm chính của file này.
class OrderItemEntity with _$OrderItemEntity {
  const factory OrderItemEntity({
    required int orderItemId,
    required int productId,
    required String productName,
    String? productImageUrl,
    required double unitPrice,
    required int quantity,
    required double totalPrice,
  }) = _OrderItemEntity;
}
