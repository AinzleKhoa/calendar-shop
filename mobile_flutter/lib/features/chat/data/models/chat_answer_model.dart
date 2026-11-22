import '../../domain/entities/chat_answer.dart';

// Lớp ChatAnswerModel giữ trách nhiệm chính của file này.
class ChatAnswerModel {
  final String answer;

  const ChatAnswerModel({
    required this.answer,
  });

  // Parse JSON từ backend sang model Dart.
  factory ChatAnswerModel.fromJson(Map<String, dynamic> json) {
    return ChatAnswerModel(
      answer: json['answer'] as String? ?? '',
    );
  }

  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  ChatAnswer toEntity() {
    return ChatAnswer(
      answer: answer,
    );
  }
}
