import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_customer_stats.dart';

part 'admin_customer_stats_model.freezed.dart';
part 'admin_customer_stats_model.g.dart';

@freezed
// Lớp AdminCustomerStatsModel giữ trách nhiệm chính của file này.
class AdminCustomerStatsModel with _$AdminCustomerStatsModel {
  const factory AdminCustomerStatsModel({
    required int totalCustomers,
    @Default(0.0) double totalCustomersGrowth,
    required int newCustomers,
    @Default(0.0) double newCustomersGrowth,
    required int loyalCustomers,
    required int lockedAccounts,
    required List<CustomerRankDistributionModel> rankDistribution,
    required List<TopCustomerModel> topCustomers,
  }) = _AdminCustomerStatsModel;

  // Parse JSON từ backend sang model Dart.
  factory AdminCustomerStatsModel.fromJson(Map<String, dynamic> json) =>
      _$AdminCustomerStatsModelFromJson(json);
}

@freezed
// Lớp CustomerRankDistributionModel giữ trách nhiệm chính của file này.
class CustomerRankDistributionModel with _$CustomerRankDistributionModel {
  const factory CustomerRankDistributionModel({
    required String rank,
    required int total,
    required double percentage,
  }) = _CustomerRankDistributionModel;

  // Parse JSON từ backend sang model Dart.
  factory CustomerRankDistributionModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerRankDistributionModelFromJson(json);
}

@freezed
// Lớp TopCustomerModel giữ trách nhiệm chính của file này.
class TopCustomerModel with _$TopCustomerModel {
  const factory TopCustomerModel({
    required int userId,
    required String fullName,
    required String email,
    required String rank,
    required int totalOrders,
    required double totalSpent,
  }) = _TopCustomerModel;

  // Parse JSON từ backend sang model Dart.
  factory TopCustomerModel.fromJson(Map<String, dynamic> json) =>
      _$TopCustomerModelFromJson(json);
}

extension AdminCustomerStatsModelMapper on AdminCustomerStatsModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AdminCustomerStats toEntity() => AdminCustomerStats(
        totalCustomers: totalCustomers,
        totalCustomersGrowth: totalCustomersGrowth,
        newCustomers: newCustomers,
        newCustomersGrowth: newCustomersGrowth,
        loyalCustomers: loyalCustomers,
        lockedAccounts: lockedAccounts,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        rankDistribution: rankDistribution.map((e) => e.toEntity()).toList(),
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        topCustomers: topCustomers.map((e) => e.toEntity()).toList(),
      );
}

extension CustomerRankDistributionModelMapper on CustomerRankDistributionModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  CustomerRankDistribution toEntity() => CustomerRankDistribution(
        rank: rank,
        total: total,
        percentage: percentage,
      );
}

extension TopCustomerModelMapper on TopCustomerModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  TopCustomer toEntity() => TopCustomer(
        userId: userId,
        fullName: fullName,
        email: email,
        rank: rank,
        totalOrders: totalOrders,
        totalSpent: totalSpent,
      );
}
