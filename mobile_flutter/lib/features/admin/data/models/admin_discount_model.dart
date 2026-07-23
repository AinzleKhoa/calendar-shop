import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/admin_discount.dart';

part 'admin_discount_model.freezed.dart';
part 'admin_discount_model.g.dart';

@freezed
// Lớp AdminDiscountModel giữ trách nhiệm chính của file này.
class AdminDiscountModel with _$AdminDiscountModel {
  const factory AdminDiscountModel({
    required int discountId,
    required String name,
    required String discountType,
    required double discountValue,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
    required DateTime createdAt,
    @Default([]) List<int> productIds,
    @Default([]) List<int> categoryIds,
  }) = _AdminDiscountModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminDiscountModel.fromJson(Map<String, dynamic> json) => _$AdminDiscountModelFromJson(json);
}

extension AdminDiscountModelMapper on AdminDiscountModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminDiscount toEntity() => AdminDiscount(
        discountId: discountId,
        name: name,
        discountType: discountType,
        discountValue: discountValue,
        startDate: startDate,
        endDate: endDate,
        status: status,
        createdAt: createdAt,
        productIds: productIds,
        categoryIds: categoryIds,
      );
}
