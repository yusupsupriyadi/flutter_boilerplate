# flutter_secure_storage

`10.3.1` · Storage · [pub.dev](https://pub.dev/packages/flutter_secure_storage)

Encrypted key/value storage backed by the platform keystore (iOS Keychain, Android KeyStore). For sensitive data — auth access/refresh tokens. Non-sensitive flags go to [shared_preferences](shared_preferences.md) instead.

**Where:** `lib/core/storage/secure_storage_service.dart` (`SecureStorageService`), `app_providers.dart` (`secureStorageServiceProvider`), `api_client.dart` (reads token for `Bearer` header).

```dart
Future<void> saveAccessToken(String token) =>
    write(key: _accessTokenKey, value: token);
Future<String?> readAccessToken() => read(key: _accessTokenKey);
```

**Note:** Constructor takes an optional `FlutterSecureStorage?` for test mocking. For advanced Android config use `AndroidOptions(encryptedSharedPreferences: true)`.
