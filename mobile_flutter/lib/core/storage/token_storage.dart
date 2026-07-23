import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Lớp TokenStorage giữ trách nhiệm chính của file này.
class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  // Xử lý tác vụ bất đồng bộ chính của màn hình/tầng này.
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  // Deprecated: use clearTokens() instead
  Future<void> clearToken() async {
    await clearTokens();
  }
}
