import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wraps `flutter_secure_storage` for sensitive data such as auth tokens and
/// credentials. Values are encrypted at rest by the platform keystore.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  // --- Generic API ---------------------------------------------------------
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);

  Future<String?> read({required String key}) => _storage.read(key: key);

  Future<void> delete({required String key}) => _storage.delete(key: key);

  Future<void> deleteAll() => _storage.deleteAll();

  // --- Auth token helpers --------------------------------------------------
  Future<void> saveAccessToken(String token) =>
      write(key: _accessTokenKey, value: token);

  Future<String?> readAccessToken() => read(key: _accessTokenKey);

  Future<void> saveRefreshToken(String token) =>
      write(key: _refreshTokenKey, value: token);

  Future<String?> readRefreshToken() => read(key: _refreshTokenKey);

  Future<void> clearTokens() async {
    await delete(key: _accessTokenKey);
    await delete(key: _refreshTokenKey);
  }
}
