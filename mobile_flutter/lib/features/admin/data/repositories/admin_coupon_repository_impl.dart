import '../../domain/entities/admin_coupon.dart';
import '../../domain/repositories/admin_coupon_repository.dart';
import '../datasources/admin_coupon_remote_datasource.dart';
import '../models/admin_coupon_model.dart';

// Lớp AdminCouponRepositoryImpl giữ trách nhiệm chính của file này.
class AdminCouponRepositoryImpl implements AdminCouponRepository {
  final AdminCouponRemoteDataSource remoteDataSource;

  AdminCouponRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<AdminCoupon>> getCoupons() async {
    final models = await remoteDataSource.getCoupons();
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((model) => model.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<AdminCoupon> getCouponById(int id) async {
    final model = await remoteDataSource.getCouponById(id);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<AdminCoupon> createCoupon({
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required String status,
  }) async {
    final model = await remoteDataSource.createCoupon(
      code: code,
      description: description,
      discountType: discountType,
      discountValue: discountValue,
      minOrderValue: minOrderValue,
      startDate: startDate,
      endDate: endDate,
      usageLimit: usageLimit,
      status: status,
    );
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> updateCoupon(
    int id, {
    required String code,
    String? description,
    required String discountType,
    required double discountValue,
    required double minOrderValue,
    required DateTime startDate,
    required DateTime endDate,
    int? usageLimit,
    required String status,
  }) {
    return remoteDataSource.updateCoupon(
      id,
      code: code,
      description: description,
      discountType: discountType,
      discountValue: discountValue,
      minOrderValue: minOrderValue,
      startDate: startDate,
      endDate: endDate,
      usageLimit: usageLimit,
      status: status,
    );
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> updateCouponStatus(int id, String status) {
    return remoteDataSource.updateCouponStatus(id, status);
  }
}
