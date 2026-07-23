// Lớp AppException giữ trách nhiệm chính của file này.
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}
