import 'package:freezed_annotation/freezed_annotation.dart';
import 'app_user.dart';

part 'auth_result.freezed.dart';

@freezed
// Lớp AuthResult giữ trách nhiệm chính của file này.
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required String token,
    required String refreshToken,
    required AppUser user,
  }) = _AuthResult;
}
