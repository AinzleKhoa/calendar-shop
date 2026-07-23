import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/chat_answer_model.dart';

// Lớp ChatRemoteDataSource giữ trách nhiệm chính của file này.
class ChatRemoteDataSource {
  final ApiClient apiClient;

  ChatRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<ChatAnswerModel> ask(String message) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.chatAsk,
        data: {'message': message},
        options: Options(
          receiveTimeout: const Duration(seconds: 360),
          sendTimeout: const Duration(seconds: 30),
        ),
      );
      // Parse JSON từ backend sang model Dart.
      return ChatAnswerModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }
}
