import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_item_entity.dart';

part 'order_entity.freezed.dart';

@freezed
class OrderEntity with _$OrderEntity {
  const factory OrderEntity({
    required int orderId,
    required int userId,
    required String customerName,
    required String customerPhone,
    required String shippingAddress,
    required double subTotal,
    required double discountAmount,
    required double shippingFee,
    required double totalAmount,
    required String paymentMethod,
    required String status,
    String? note,
    String? cancelReason,
    required DateTime createdAt,
    DateTime? updatedAt,
    required List<OrderItemEntity> items,
  }) = _OrderEntity;
}
