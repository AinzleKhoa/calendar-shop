import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_category_stats.dart';

part 'admin_category_stats_model.freezed.dart';
part 'admin_category_stats_model.g.dart';

@freezed
// Lớp AdminCategoryStatsModel giữ trách nhiệm chính của file này.
class AdminCategoryStatsModel with _$AdminCategoryStatsModel {
  const factory AdminCategoryStatsModel({
    required int totalCategories,
    required int activeCategories,
    required int hiddenCategories,
    required List<CategoryProductDistributionModel> productDistribution,
  }) = _AdminCategoryStatsModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminCategoryStatsModel.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryStatsModelFromJson(json);
}

@freezed
// Lớp CategoryProductDistributionModel giữ trách nhiệm chính của file này.
class CategoryProductDistributionModel with _$CategoryProductDistributionModel {
  const factory CategoryProductDistributionModel({
    required String categoryName,
    required int productCount,
    required double percentage,
  }) = _CategoryProductDistributionModel;

  // Parse JSON từ backend sang model Dart.
  factory CategoryProductDistributionModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductDistributionModelFromJson(json);
}

extension AdminCategoryStatsModelMapper on AdminCategoryStatsModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminCategoryStats toEntity() => AdminCategoryStats(
        totalCategories: totalCategories,
        activeCategories: activeCategories,
        hiddenCategories: hiddenCategories,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        productDistribution: productDistribution.map((e) => e.toEntity()).toList(),
      );
}

extension CategoryProductDistributionModelMapper on CategoryProductDistributionModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  CategoryProductDistribution toEntity() => CategoryProductDistribution(
        categoryName: categoryName,
        productCount: productCount,
        percentage: percentage,
      );
}
