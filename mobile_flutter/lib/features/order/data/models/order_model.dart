import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_entity.dart';
import 'order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
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
    String? cancelReason,
    required DateTime createdAt,
    DateTime? updatedAt,
    required List<OrderItemModel> items,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

extension OrderModelMapper on OrderModel {
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
        cancelReason: cancelReason,
        createdAt: createdAt,
        updatedAt: updatedAt,
        items: items.map((item) => item.toEntity()).toList(),
      );
}
