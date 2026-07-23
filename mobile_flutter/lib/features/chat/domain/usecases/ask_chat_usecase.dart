import '../entities/chat_answer.dart';
import '../repositories/chat_repository.dart';

// Lớp AskChatUseCase giữ trách nhiệm chính của file này.
class AskChatUseCase {
  final ChatRepository repository;

  AskChatUseCase(this.repository);

  Future<ChatAnswer> call(String message) {
    return repository.ask(message);
  }
}
