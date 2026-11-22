import '../entities/notification_entity.dart';

// Lớp NotificationRepository giữ trách nhiệm chính của file này.
abstract class NotificationRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<List<NotificationEntity>> getNotifications();
  Future<void> markAsRead(int id);
  Future<void> markAllAsRead();
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> registerFcmToken(String token);
  Future<void> triggerHolidayReminders();
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> deleteNotification(int id);
}
