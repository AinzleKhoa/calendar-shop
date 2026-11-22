import '../../domain/entities/checked_coupon.dart';

// Lớp CheckedCouponModel giữ trách nhiệm chính của file này.
class CheckedCouponModel {
  final String code;
  final String discountType;
  final double discountValue;

  const CheckedCouponModel({
    required this.code,
    required this.discountType,
    required this.discountValue,
  });

  // Parse JSON từ backend sang model Dart.
  factory CheckedCouponModel.fromJson(Map<String, dynamic> json) {
    return CheckedCouponModel(
      code: json['code'] as String,
      discountType: json['discountType'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
    );
  }

  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  CheckedCoupon toEntity() => CheckedCoupon(
        code: code,
        discountType: discountType,
        discountValue: discountValue,
      );
}
