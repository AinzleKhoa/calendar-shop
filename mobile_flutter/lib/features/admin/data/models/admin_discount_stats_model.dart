import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_discount_stats.dart';

part 'admin_discount_stats_model.freezed.dart';
part 'admin_discount_stats_model.g.dart';

@freezed
// Lớp AdminDiscountStatsModel giữ trách nhiệm chính của file này.
class AdminDiscountStatsModel with _$AdminDiscountStatsModel {
  const factory AdminDiscountStatsModel({
    required int totalDiscounts,
    required int activeDiscounts,
    required int expiredDiscounts,
    required List<DiscountTypeDistributionModel> typeDistribution,
    required List<TopDiscountModel> topDiscounts,
  }) = _AdminDiscountStatsModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminDiscountStatsModel.fromJson(Map<String, dynamic> json) =>
      _$AdminDiscountStatsModelFromJson(json);
}

@freezed
// Lớp DiscountTypeDistributionModel giữ trách nhiệm chính của file này.
class DiscountTypeDistributionModel with _$DiscountTypeDistributionModel {
  const factory DiscountTypeDistributionModel({
    required String type,
    required int total,
    required double percentage,
  }) = _DiscountTypeDistributionModel;

  // Parse JSON từ backend sang model Dart.
  factory DiscountTypeDistributionModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountTypeDistributionModelFromJson(json);
}

@freezed
// Lớp TopDiscountModel giữ trách nhiệm chính của file này.
class TopDiscountModel with _$TopDiscountModel {
  const factory TopDiscountModel({
    required int discountId,
    required String code,
    required int usageCount,
  }) = _TopDiscountModel;

  // Parse JSON từ backend sang model Dart.
  factory TopDiscountModel.fromJson(Map<String, dynamic> json) =>
      _$TopDiscountModelFromJson(json);
}

extension AdminDiscountStatsModelMapper on AdminDiscountStatsModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminDiscountStats toEntity() => AdminDiscountStats(
        totalDiscounts: totalDiscounts,
        activeDiscounts: activeDiscounts,
        expiredDiscounts: expiredDiscounts,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        typeDistribution: typeDistribution.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        topDiscounts: topDiscounts.map((e) => e.toEntity()).toList(),
      );
}

extension DiscountTypeDistributionModelMapper on DiscountTypeDistributionModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  DiscountTypeDistribution toEntity() => DiscountTypeDistribution(
        type: type,
        total: total,
        percentage: percentage,
      );
}

extension TopDiscountModelMapper on TopDiscountModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  TopDiscount toEntity() => TopDiscount(
        discountId: discountId,
        code: code,
        usageCount: usageCount,
      );
}
