import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../models/notification_model.dart';

// Lớp NotificationRepositoryImpl giữ trách nhiệm chính của file này.
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final models = await remoteDataSource.getNotifications();
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> markAsRead(int id) async {
    await remoteDataSource.markAsRead(id);
  }

  @override
  Future<void> markAllAsRead() async {
    await remoteDataSource.markAllAsRead();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> registerFcmToken(String token) async {
    await remoteDataSource.registerFcmToken(token);
  }

  @override
  Future<void> triggerHolidayReminders() async {
    await remoteDataSource.triggerHolidayReminders();
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<void> deleteNotification(int id) async {
    await remoteDataSource.deleteNotification(id);
  }
}
