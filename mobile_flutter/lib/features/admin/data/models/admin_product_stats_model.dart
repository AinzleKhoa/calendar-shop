import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_product_stats.dart';

part 'admin_product_stats_model.freezed.dart';
part 'admin_product_stats_model.g.dart';

@freezed
// Lớp AdminProductStatsModel giữ trách nhiệm chính của file này.
class AdminProductStatsModel with _$AdminProductStatsModel {
  const factory AdminProductStatsModel({
    required int totalProducts,
    @Default(0.0) double totalProductsGrowth,
    required int inBusiness,
    @Default(0.0) double inBusinessGrowth,
    required int lowStock,
    required int totalCategories,
    required List<ProductBestSellingModel> bestSelling,
    required List<CategoryStockDistributionModel> stockByCategory,
    required List<ProductLowStockModel> lowStockProducts,
  }) = _AdminProductStatsModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminProductStatsModel.fromJson(Map<String, dynamic> json) =>
      _$AdminProductStatsModelFromJson(json);
}

@freezed
// Lớp ProductBestSellingModel giữ trách nhiệm chính của file này.
class ProductBestSellingModel with _$ProductBestSellingModel {
  const factory ProductBestSellingModel({
    required int productId,
    required String productName,
    required int totalSold,
  }) = _ProductBestSellingModel;

  // Parse JSON từ backend sang model Dart.
  factory ProductBestSellingModel.fromJson(Map<String, dynamic> json) =>
      _$ProductBestSellingModelFromJson(json);
}

@freezed
// Lớp CategoryStockDistributionModel giữ trách nhiệm chính của file này.
class CategoryStockDistributionModel with _$CategoryStockDistributionModel {
  const factory CategoryStockDistributionModel({
    required String categoryName,
    required int totalStock,
    required double percentage,
  }) = _CategoryStockDistributionModel;

  // Parse JSON từ backend sang model Dart.
  factory CategoryStockDistributionModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryStockDistributionModelFromJson(json);
}

@freezed
// Lớp ProductLowStockModel giữ trách nhiệm chính của file này.
class ProductLowStockModel with _$ProductLowStockModel {
  const factory ProductLowStockModel({
    required int productId,
    required String productName,
    required int stockQuantity,
  }) = _ProductLowStockModel;

  // Parse JSON từ backend sang model Dart.
  factory ProductLowStockModel.fromJson(Map<String, dynamic> json) =>
      _$ProductLowStockModelFromJson(json);
}

extension AdminProductStatsModelMapper on AdminProductStatsModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminProductStats toEntity() => AdminProductStats(
        totalProducts: totalProducts,
        totalProductsGrowth: totalProductsGrowth,
        inBusiness: inBusiness,
        inBusinessGrowth: inBusinessGrowth,
        lowStock: lowStock,
        totalCategories: totalCategories,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        bestSelling: bestSelling.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        stockByCategory: stockByCategory.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        lowStockProducts: lowStockProducts.map((e) => e.toEntity()).toList(),
      );
}

extension ProductBestSellingModelMapper on ProductBestSellingModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  ProductBestSelling toEntity() => ProductBestSelling(
        productId: productId,
        productName: productName,
        totalSold: totalSold,
      );
}

extension CategoryStockDistributionModelMapper on CategoryStockDistributionModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  CategoryStockDistribution toEntity() => CategoryStockDistribution(
        categoryName: categoryName,
        totalStock: totalStock,
        percentage: percentage,
      );
}

extension ProductLowStockModelMapper on ProductLowStockModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  ProductLowStock toEntity() => ProductLowStock(
        productId: productId,
        productName: productName,
        stockQuantity: stockQuantity,
      );
}
