import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../network/api_client.dart';
import '../providers/core_providers.dart';

final imageUploadServiceProvider = Provider<ImageUploadService>((ref) {
  return ImageUploadService(ref.watch(apiClientProvider));
});

class ImageUploadService {
  final ApiClient apiClient;

  ImageUploadService(this.apiClient);

  Future<String?> pickAndUploadImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final pickedFile = result.files.single;
    final multipartFile = pickedFile.bytes != null
        ? MultipartFile.fromBytes(
            pickedFile.bytes!,
            filename: pickedFile.name,
          )
        : pickedFile.path != null
            ? await MultipartFile.fromFile(
                pickedFile.path!,
                filename: pickedFile.name,
              )
            : throw Exception('Không đọc được file ảnh đã chọn.');

    final formData = FormData.fromMap({'file': multipartFile});
    final response = await apiClient.dio.post(
      '${ApiConstants.uploads}/images',
      data: formData,
    );

    return response.data['url'] as String?;
  }
}
