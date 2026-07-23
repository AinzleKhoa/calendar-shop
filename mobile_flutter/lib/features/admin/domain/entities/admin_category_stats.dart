import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_category_stats.freezed.dart';

@freezed
// Lớp AdminCategoryStats giữ trách nhiệm chính của file này.
class AdminCategoryStats with _$AdminCategoryStats {
  const factory AdminCategoryStats({
    @Default(0) int totalCategories,
    @Default(0) int activeCategories,
    @Default(0) int hiddenCategories,
    @Default([]) List<CategoryProductDistribution> productDistribution,
  }) = _AdminCategoryStats;
}

@freezed
// Lớp CategoryProductDistribution giữ trách nhiệm chính của file này.
class CategoryProductDistribution with _$CategoryProductDistribution {
  const factory CategoryProductDistribution({
    @Default('') String categoryName,
    @Default(0) int productCount,
    @Default(0.0) double percentage,
  }) = _CategoryProductDistribution;
}
