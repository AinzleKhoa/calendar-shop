import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
// Lớp OrderItemModel giữ trách nhiệm chính của file này.
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required int orderItemId,
    required int productId,
    required String productName,
    String? productImageUrl,
    required double unitPrice,
    required int quantity,
    required double totalPrice,
  }) = _OrderItemModel;

  // Parse JSON từ backend sang model Dart.
  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}

@freezed
// Lớp OrderModel giữ trách nhiệm chính của file này.
class OrderModel with _$OrderModel {
  const factory OrderModel({
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
    required DateTime createdAt,
    @Default([]) List<OrderItemModel> items,
  }) = _OrderModel;

  // Parse JSON từ backend sang model Dart.
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

extension OrderItemModelMapper on OrderItemModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  OrderItemEntity toEntity() => OrderItemEntity(
        orderItemId: orderItemId,
        productId: productId,
        productName: productName,
        productImageUrl: productImageUrl,
        unitPrice: unitPrice,
        quantity: quantity,
        totalPrice: totalPrice,
      );
}

extension OrderModelMapper on OrderModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  OrderEntity toEntity() => OrderEntity(
        orderId: orderId,
        userId: userId,
        customerName: customerName,
        customerPhone: customerPhone,
        shippingAddress: shippingAddress,
        subTotal: subTotal,
        discountAmount: discountAmount,
        shippingFee: shippingFee,
        totalAmount: totalAmount,
        paymentMethod: paymentMethod,
        status: status,
        note: note,
        createdAt: createdAt,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        items: items.map((item) => item.toEntity()).toList(),
      );
}
