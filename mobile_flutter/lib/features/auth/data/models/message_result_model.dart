import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_result_model.freezed.dart';
part 'message_result_model.g.dart';

@freezed
// Lớp MessageResultModel giữ trách nhiệm chính của file này.
class MessageResultModel with _$MessageResultModel {
  const factory MessageResultModel({
    required String message,
  }) = _MessageResultModel;

  // Parse JSON từ backend sang model Dart.
  factory MessageResultModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResultModelFromJson(json);
}
