import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasources/address_remote_datasource.dart';

// Lớp AddressRepositoryImpl giữ trách nhiệm chính của file này.
class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<Address>> getAddresses() async {
    final models = await remoteDataSource.getAddresses();
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((e) => e.toEntity()).toList();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<Address> getAddressById(int addressId) async {
    final model = await remoteDataSource.getAddressById(addressId);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<Address> createAddress({
    required String receiverName,
    required String receiverPhone,
    required String province,
    required String district,
    String? ward,
    required String addressLine,
    required bool isDefault,
  }) async {
    final model = await remoteDataSource.createAddress({
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'province': province,
      'district': district,
      'ward': ward,
      'addressLine': addressLine,
      'isDefault': isDefault,
    });
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<Address> updateAddress({
    required int addressId,
    required String receiverName,
    required String receiverPhone,
    required String province,
    required String district,
    String? ward,
    required String addressLine,
    required bool isDefault,
  }) async {
    final model = await remoteDataSource.updateAddress(addressId, {
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'province': province,
      'district': district,
      'ward': ward,
      'addressLine': addressLine,
      'isDefault': isDefault,
    });
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> deleteAddress(int addressId) async {
    await remoteDataSource.deleteAddress(addressId);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> setDefaultAddress(int addressId) async {
    await remoteDataSource.setDefaultAddress(addressId);
  }
}
