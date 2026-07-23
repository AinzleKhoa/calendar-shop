import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/admin_coupon.dart';

part 'admin_coupon_model.freezed.dart';
part 'admin_coupon_model.g.dart';

@freezed
// Lớp AdminCouponModel giữ trách nhiệm chính của file này.
class AdminCouponModel with _$AdminCouponModel {
  const factory AdminCouponModel({
    required int couponId,
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required int usedCount,
    required String status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _AdminCouponModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminCouponModel.fromJson(Map<String, dynamic> json) =>
      _$AdminCouponModelFromJson(json);
}

extension AdminCouponModelMapper on AdminCouponModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminCoupon toEntity() => AdminCoupon(
        couponId: couponId,
        code: code,
        description: description,
        discountType: discountType,
        discountValue: discountValue,
        minOrderValue: minOrderValue,
        startDate: startDate,
        endDate: endDate,
        usageLimit: usageLimit,
        usedCount: usedCount,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
