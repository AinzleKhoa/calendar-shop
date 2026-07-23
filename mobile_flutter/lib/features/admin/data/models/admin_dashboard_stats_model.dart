import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_dashboard_stats.dart';

part 'admin_dashboard_stats_model.freezed.dart';
part 'admin_dashboard_stats_model.g.dart';

@freezed
// Lớp AdminDashboardStatsModel giữ trách nhiệm chính của file này.
class AdminDashboardStatsModel with _$AdminDashboardStatsModel {
  const factory AdminDashboardStatsModel({
    required int totalUsers,
    required double totalRevenue,
    required int totalOrders,
    required int totalProductsSold,
    required double totalOrdersGrowth,
    required double totalRevenueGrowth,
    required int newProductsCount,
    required int totalProducts,
    required int totalOutOfStock,
    required int totalLowStock,
    required List<StatusCountModel> ordersByStatus,
    required List<BestSellingProductModel> bestSelling,
    required List<RevenueByDayModel> revenueByDay,
    required List<RevenueByMonthModel> revenueByMonth,
    required List<RecentOrderModel> recentOrders,
    required List<LowStockProductModel> lowStockProducts,
  }) = _AdminDashboardStatsModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminDashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardStatsModelFromJson(json);
}

@freezed
// Lớp StatusCountModel giữ trách nhiệm chính của file này.
class StatusCountModel with _$StatusCountModel {
  const factory StatusCountModel({
    required String status,
    required int total,
  }) = _StatusCountModel;

  // Parse JSON từ backend sang model Dart.
  factory StatusCountModel.fromJson(Map<String, dynamic> json) =>
      _$StatusCountModelFromJson(json);
}

@freezed
// Lớp BestSellingProductModel giữ trách nhiệm chính của file này.
class BestSellingProductModel with _$BestSellingProductModel {
  const factory BestSellingProductModel({
    required int productId,
    required String productName,
    required int totalSold,
  }) = _BestSellingProductModel;

  // Parse JSON từ backend sang model Dart.
  factory BestSellingProductModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellingProductModelFromJson(json);
}

@freezed
// Lớp RevenueByDayModel giữ trách nhiệm chính của file này.
class RevenueByDayModel with _$RevenueByDayModel {
  const factory RevenueByDayModel({
    required DateTime date,
    required double revenue,
    required int orderCount,
  }) = _RevenueByDayModel;

  // Parse JSON từ backend sang model Dart.
  factory RevenueByDayModel.fromJson(Map<String, dynamic> json) =>
      _$RevenueByDayModelFromJson(json);
}

@freezed
// Lớp RevenueByMonthModel giữ trách nhiệm chính của file này.
class RevenueByMonthModel with _$RevenueByMonthModel {
  const factory RevenueByMonthModel({
    required int year,
    required int month,
    required double revenue,
    required int orderCount,
  }) = _RevenueByMonthModel;

  // Parse JSON từ backend sang model Dart.
  factory RevenueByMonthModel.fromJson(Map<String, dynamic> json) =>
      _$RevenueByMonthModelFromJson(json);
}

@freezed
// Lớp RecentOrderModel giữ trách nhiệm chính của file này.
class RecentOrderModel with _$RecentOrderModel {
  const factory RecentOrderModel({
    required int orderId,
    required String customerName,
    required double totalAmount,
    required String status,
    required DateTime createdAt,
    required String productName,
    String? productImageUrl,
  }) = _RecentOrderModel;

  // Parse JSON từ backend sang model Dart.
  factory RecentOrderModel.fromJson(Map<String, dynamic> json) =>
      _$RecentOrderModelFromJson(json);
}

@freezed
// Lớp LowStockProductModel giữ trách nhiệm chính của file này.
class LowStockProductModel with _$LowStockProductModel {
  const factory LowStockProductModel({
    required int productId,
    required String productName,
    required int stockQuantity,
  }) = _LowStockProductModel;

  // Parse JSON từ backend sang model Dart.
  factory LowStockProductModel.fromJson(Map<String, dynamic> json) =>
      _$LowStockProductModelFromJson(json);
}

extension AdminDashboardStatsModelMapper on AdminDashboardStatsModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminDashboardStats toEntity() => AdminDashboardStats(
        totalUsers: totalUsers,
        totalRevenue: totalRevenue,
        totalOrders: totalOrders,
        totalProductsSold: totalProductsSold,
        totalOrdersGrowth: totalOrdersGrowth,
        totalRevenueGrowth: totalRevenueGrowth,
        newProductsCount: newProductsCount,
        totalProducts: totalProducts,
        totalOutOfStock: totalOutOfStock,
        totalLowStock: totalLowStock,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        ordersByStatus: ordersByStatus.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        bestSelling: bestSelling.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        revenueByDay: revenueByDay.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        revenueByMonth: revenueByMonth.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        recentOrders: recentOrders.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        lowStockProducts: lowStockProducts.map((e) => e.toEntity()).toList(),
      );
}

extension StatusCountModelMapper on StatusCountModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  StatusCount toEntity() => StatusCount(
        status: status,
        total: total,
      );
}

extension BestSellingProductModelMapper on BestSellingProductModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  BestSellingProduct toEntity() => BestSellingProduct(
        productId: productId,
        productName: productName,
        totalSold: totalSold,
      );
}

extension RevenueByDayModelMapper on RevenueByDayModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  RevenueByDay toEntity() => RevenueByDay(
        date: date,
        revenue: revenue,
        orderCount: orderCount,
      );
}

extension RevenueByMonthModelMapper on RevenueByMonthModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  RevenueByMonth toEntity() => RevenueByMonth(
        year: year,
        month: month,
        revenue: revenue,
        orderCount: orderCount,
      );
}

extension RecentOrderModelMapper on RecentOrderModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  RecentOrder toEntity() => RecentOrder(
        orderId: orderId,
        customerName: customerName,
        totalAmount: totalAmount,
        status: status,
        createdAt: createdAt,
        productName: productName,
        productImageUrl: productImageUrl,
      );
}

extension LowStockProductModelMapper on LowStockProductModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  LowStockProduct toEntity() => LowStockProduct(
        productId: productId,
        productName: productName,
        stockQuantity: stockQuantity,
      );
}
