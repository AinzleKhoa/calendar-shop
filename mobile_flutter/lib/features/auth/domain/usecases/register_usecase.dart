import '../repositories/auth_repository.dart';

// Lớp RegisterUseCase giữ trách nhiệm chính của file này.
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<String> call({required String fullName, String? email, String? phone, required String password}) {
    return repository.register(fullName: fullName, email: email, phone: phone, password: password);
  }
}
