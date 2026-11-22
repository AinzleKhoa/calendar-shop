import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/address_model.dart';

// Lớp AddressRemoteDataSource giữ trách nhiệm chính của file này.
class AddressRemoteDataSource {
  final ApiClient apiClient;

  AddressRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<AddressModel>> getAddresses() async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(ApiConstants.addresses);

      final List dataList;
      if (response.data is Map && (response.data as Map).containsKey('value')) {
        dataList = response.data['value'] as List;
      } else if (response.data is List) {
        dataList = response.data as List;
      } else {
        dataList = [];
      }

      // Parse JSON từ backend sang model Dart.
      return dataList.map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AddressModel> getAddressById(int addressId) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get('${ApiConstants.addresses}/$addressId');
      // Parse JSON từ backend sang model Dart.
      return AddressModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AddressModel> createAddress(Map<String, dynamic> data) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(ApiConstants.addresses, data: data);
      // Parse JSON từ backend sang model Dart.
      return AddressModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AddressModel> updateAddress(int addressId, Map<String, dynamic> data) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      final response = await apiClient.dio.put('${ApiConstants.addresses}/$addressId', data: data);
      // Parse JSON từ backend sang model Dart.
      return AddressModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteAddress(int addressId) async {
    try {
      // Gọi API DELETE để xóa dữ liệu trên backend.
      await apiClient.dio.delete('${ApiConstants.addresses}/$addressId');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> setDefaultAddress(int addressId) async {
    try {
      await apiClient.dio.patch('${ApiConstants.addresses}/$addressId/default');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
