import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_request.freezed.dart';
part 'create_order_request.g.dart';

@freezed
// Lớp CreateOrderRequest giữ trách nhiệm chính của file này.
class CreateOrderRequest with _$CreateOrderRequest {
  const factory CreateOrderRequest({
    required String customerName,
    required String customerPhone,
    required String shippingAddress,
    required String paymentMethod,
    String? couponCode,
    String? note,
  }) = _CreateOrderRequest;

  // Parse JSON từ backend sang model Dart.
  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);
}
