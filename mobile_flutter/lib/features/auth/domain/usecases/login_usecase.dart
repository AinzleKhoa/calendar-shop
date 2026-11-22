import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

// Lớp LoginUseCase giữ trách nhiệm chính của file này.
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResult> call({required String login, required String password}) {
    return repository.login(login: login, password: password);
  }
}
