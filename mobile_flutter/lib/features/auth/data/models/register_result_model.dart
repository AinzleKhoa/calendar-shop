import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_result_model.freezed.dart';
part 'register_result_model.g.dart';

@freezed
// Lớp RegisterResultModel giữ trách nhiệm chính của file này.
class RegisterResultModel with _$RegisterResultModel {
  const factory RegisterResultModel({
    required String message,
  }) = _RegisterResultModel;

  // Parse JSON từ backend sang model Dart.
  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultModelFromJson(json);
}
