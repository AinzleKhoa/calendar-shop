import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/notification_model.dart';

// Lớp NotificationRemoteDataSource giữ trách nhiệm chính của file này.
class NotificationRemoteDataSource {
  final ApiClient apiClient;

  NotificationRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<NotificationModel>> getNotifications() async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(ApiConstants.notifications);
      final data = response.data;
      final list = data is Map && data['value'] is List ? data['value'] as List : data as List;
      // Parse JSON từ backend sang model Dart.
      return list.map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.notifications}/$id/read');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put('${ApiConstants.notifications}/read-all');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> registerFcmToken(String token) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post('${ApiConstants.notifications}/register-token', data: {
        'fcmToken': token,
      });
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<void> triggerHolidayReminders() async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post('${ApiConstants.notifications}/trigger-holiday');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteNotification(int id) async {
    try {
      // Gọi API DELETE để xóa dữ liệu trên backend.
      await apiClient.dio.delete('${ApiConstants.notifications}/$id');
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
