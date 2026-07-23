import '../../domain/entities/chat_answer.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

// Lớp ChatRepositoryImpl giữ trách nhiệm chính của file này.
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  @override
  Future<ChatAnswer> ask(String message) async {
    final model = await remoteDataSource.ask(message);
    // Chuyển model DTO sang entity domain trước khi đưa lên UI.
    return model.toEntity();
  }
}
