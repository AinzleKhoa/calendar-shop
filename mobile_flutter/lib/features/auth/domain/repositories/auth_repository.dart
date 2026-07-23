import '../entities/auth_result.dart';
import '../entities/app_user.dart';

// Lớp ForgotPasswordResult giữ trách nhiệm chính của file này.
class ForgotPasswordResult {
  final String message;
  final DateTime? expiredAt;

  const ForgotPasswordResult({
    required this.message,
    this.expiredAt,
  });
}

// Lớp AuthRepository giữ trách nhiệm chính của file này.
abstract class AuthRepository {
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AuthResult> login({required String login, required String password});
  Future<AuthResult> googleLogin({required String email, String? fullName, String? photoUrl, String? idToken});
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<String> register({required String fullName, String? email, String? phone, required String password});
  Future<AppUser> me();
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AppUser> updateProfile({
    required String fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
  });
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> changePassword({required String oldPassword, required String newPassword});
  Future<ForgotPasswordResult> forgotPassword({required String login});
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<String> verifyResetCode({required String resetCode});
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> resetPassword({required String resetToken, required String newPassword});
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<String> confirmEmail({required String email, required String otp});
  Future<String> resendEmailConfirmation({required String email});
  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> logout();
}
