import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/checked_coupon_model.dart';
import '../models/cart_item_model.dart';

/// Lớp chịu trách nhiệm gọi các API thô liên quan đến giỏ hàng từ Server.
class CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSource(this.apiClient);

  /// Lấy danh sách sản phẩm trong giỏ hàng (API dạng OData)
  Future<List<CartItemModel>> getCart() async {
    try {
      // Gọi HTTP GET /api/cart
      final response = await apiClient.dio.get(ApiConstants.cart);

      // Vì OData bọc danh sách trong thuộc tính "value", ta cần bóc tách dữ liệu
      final List dataList;
      if (response.data is Map && (response.data as Map).containsKey('value')) {
        dataList = response.data['value'] as List;
      } else if (response.data is List) {
        dataList = response.data as List;
      } else {
        dataList = [];
      }

      // Map từng phần tử JSON sang CartItemModel DTO
      return dataList.map((e) => CartItemModel.fromJson(e)).toList();
    } catch (e) {
      // Chuyển đổi và ném ra lỗi chuẩn hóa RFC 7807
      throw apiClient.handleError(e);
    }
  }

  /// Thêm một sản phẩm vào giỏ hàng
  Future<void> addToCart(int productId, int quantity) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post(ApiConstants.cart, data: {
        'productId': productId,
        'quantity': quantity,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  /// Cập nhật số lượng và tích chọn của sản phẩm trong giỏ hàng
  Future<void> updateCartItem(int cartItemId, int quantity, bool isSelected) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.cart}/$cartItemId', data: {
        'quantity': quantity,
        'isSelected': isSelected,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  /// Xóa sản phẩm khỏi giỏ hàng
  Future<void> deleteCartItem(int cartItemId) async {
    try {
      // Gọi API DELETE để xóa dữ liệu trên backend.
      await apiClient.dio.delete('${ApiConstants.cart}/$cartItemId');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<CheckedCouponModel> checkCoupon(String code, double subTotal) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(
        '${ApiConstants.coupons}/check',
        queryParameters: {
          'code': code,
          'subTotal': subTotal,
        },
      );

      // Parse JSON từ backend sang model Dart.
      return CheckedCouponModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
