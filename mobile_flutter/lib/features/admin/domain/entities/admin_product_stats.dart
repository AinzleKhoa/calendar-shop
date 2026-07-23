import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_product_stats.freezed.dart';

@freezed
// Lớp AdminProductStats giữ trách nhiệm chính của file này.
class AdminProductStats with _$AdminProductStats {
  const factory AdminProductStats({
    @Default(0) int totalProducts,
    @Default(0.0) double totalProductsGrowth,
    @Default(0) int inBusiness,
    @Default(0.0) double inBusinessGrowth,
    @Default(0) int lowStock,
    @Default(0) int totalCategories,
    @Default([]) List<ProductBestSelling> bestSelling,
    @Default([]) List<CategoryStockDistribution> stockByCategory,
    @Default([]) List<ProductLowStock> lowStockProducts,
  }) = _AdminProductStats;
}

@freezed
// Lớp ProductBestSelling giữ trách nhiệm chính của file này.
class ProductBestSelling with _$ProductBestSelling {
  const factory ProductBestSelling({
    @Default(0) int productId,
    @Default('') String productName,
    @Default(0) int totalSold,
  }) = _ProductBestSelling;
}

@freezed
// Lớp CategoryStockDistribution giữ trách nhiệm chính của file này.
class CategoryStockDistribution with _$CategoryStockDistribution {
  const factory CategoryStockDistribution({
    @Default('') String categoryName,
    @Default(0) int totalStock,
    @Default(0.0) double percentage,
  }) = _CategoryStockDistribution;
}

@freezed
// Lớp ProductLowStock giữ trách nhiệm chính của file này.
class ProductLowStock with _$ProductLowStock {
  const factory ProductLowStock({
    @Default(0) int productId,
    @Default('') String productName,
    @Default(0) int stockQuantity,
  }) = _ProductLowStock;
}
