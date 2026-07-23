import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/auth_result_model.dart';
import '../models/forgot_password_result_model.dart';
import '../models/message_result_model.dart';
import '../models/register_result_model.dart';
import '../models/user_model.dart';

// Lớp AuthRemoteDataSource giữ trách nhiệm chính của file này.
class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<Map<String, bool>> checkAvailability({String? email, String? phone}) async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(
        '/auth/check-availability',
        queryParameters: {
          if (email != null && email.isNotEmpty) 'email': email,
          if (phone != null && phone.isNotEmpty) 'phone': phone,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return {
        'emailExists': data['emailExists'] == true,
        'phoneExists': data['phoneExists'] == true,
      };
    } catch (_) {
      return {'emailExists': false, 'phoneExists': false};
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<AuthResultModel> login({
    required String login,
    required String password,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.login,
        data: {
          'login': login,
          'password': password,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return AuthResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<AuthResultModel> googleLogin({
    required String email,
    String? fullName,
    String? photoUrl,
    String? idToken,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.googleLogin,
        data: {
          'email': email,
          'fullName': _emptyToNull(fullName),
          'photoUrl': _emptyToNull(photoUrl),
          'idToken': _emptyToNull(idToken),
        },
      );
      // Parse JSON từ backend sang model Dart.
      return AuthResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<RegisterResultModel> register({
    required String fullName,
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.register,
        data: {
          'fullName': fullName,
          'email': _emptyToNull(email),
          'phone': _emptyToNull(phone),
          'password': password,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return RegisterResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> logout({String? refreshToken}) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post(
        ApiConstants.logout,
        data: {
          'refreshToken': _emptyToNull(refreshToken),
        },
      );
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<UserModel> me() async {
    try {
      // Gọi API GET để lấy dữ liệu từ backend.
      final response = await apiClient.dio.get(ApiConstants.me);
      // Parse JSON từ backend sang model Dart.
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<UserModel> updateProfile({
    required String fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? gender,
    DateTime? dateOfBirth,
  }) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      final response = await apiClient.dio.put(
        ApiConstants.profile,
        data: {
          'fullName': fullName,
          'email': _emptyToNull(email),
          'phone': _emptyToNull(phone),
          'avatarUrl': _emptyToNull(avatarUrl),
          'gender': _emptyToNull(gender),
          'dateOfBirth': dateOfBirth?.toIso8601String(),
        },
      );
      // Parse JSON từ backend sang model Dart.
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      // Gọi API PUT để cập nhật dữ liệu trên backend.
      await apiClient.dio.put(
        ApiConstants.changePassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<ForgotPasswordResultModel> forgotPassword({
    required String login,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.forgotPassword,
        data: {
          'login': login,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return ForgotPasswordResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<MessageResultModel> verifyResetCode({
    required String resetCode,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.verifyResetCode,
        data: {
          'resetCode': resetCode,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return MessageResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      await apiClient.dio.post(
        ApiConstants.resetPassword,
        data: {
          'resetToken': resetToken,
          'newPassword': newPassword,
        },
      );
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<MessageResultModel> confirmEmail({
    required String email,
    required String otp,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.confirmEmail,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return MessageResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  Future<MessageResultModel> resendEmailConfirmation({
    required String email,
  }) async {
    try {
      // Gọi API POST để tạo dữ liệu hoặc kích hoạt hành động backend.
      final response = await apiClient.dio.post(
        ApiConstants.resendEmailConfirmation,
        data: {
          'email': email,
        },
      );
      // Parse JSON từ backend sang model Dart.
      return MessageResultModel.fromJson(response.data);
    } catch (e) {
      throw apiClient.handleError(e);
    }
  }

  String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
