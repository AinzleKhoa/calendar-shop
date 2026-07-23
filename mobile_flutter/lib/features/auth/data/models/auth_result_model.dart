import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_result.dart';
import 'user_model.dart';

part 'auth_result_model.freezed.dart';
part 'auth_result_model.g.dart';

@freezed
// Lớp AuthResultModel giữ trách nhiệm chính của file này.
class AuthResultModel with _$AuthResultModel {
  const factory AuthResultModel({
    required String token,
    required String refreshToken,
    required UserModel user,
  }) = _AuthResultModel;

  // Parse JSON từ backend sang model Dart.
  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResultModelFromJson(json);
}

extension AuthResultModelMapper on AuthResultModel {
  // Chuyển model DTO sang entity domain trước khi đưa lên UI.
  AuthResult toEntity() => AuthResult(
        token: token,
        refreshToken: refreshToken,
        // Chuyển model DTO sang entity domain trước khi đưa lên UI.
        user: user.toEntity(),
      );
}
