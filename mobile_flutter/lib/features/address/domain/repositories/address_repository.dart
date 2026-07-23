import '../entities/address.dart';

// Lớp AddressRepository giữ trách nhiệm chính của file này.
abstract class AddressRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<Address>> getAddresses();
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Address> getAddressById(int addressId);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Address> createAddress({
    required String receiverName,
    required String receiverPhone,
    required String province,
    required String district,
    String? ward,
    required String addressLine,
    required bool isDefault,
  });
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Address> updateAddress({
    required int addressId,
    required String receiverName,
    required String receiverPhone,
    required String province,
    required String district,
    String? ward,
    required String addressLine,
    required bool isDefault,
  });
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteAddress(int addressId);
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> setDefaultAddress(int addressId);
}
