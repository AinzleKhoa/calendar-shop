import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_result_model.freezed.dart';
part 'forgot_password_result_model.g.dart';

@freezed
// Lớp ForgotPasswordResultModel giữ trách nhiệm chính của file này.
class ForgotPasswordResultModel with _$ForgotPasswordResultModel {
  const factory ForgotPasswordResultModel({
    required String message,
    DateTime? expiredAt,
  }) = _ForgotPasswordResultModel;

  // Parse JSON từ backend sang model Dart.
  factory ForgotPasswordResultModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResultModelFromJson(json);
}
