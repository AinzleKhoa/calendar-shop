import '../entities/chat_answer.dart';

// Lớp ChatRepository giữ trách nhiệm chính của file này.
abstract class ChatRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<ChatAnswer> ask(String message);
}
