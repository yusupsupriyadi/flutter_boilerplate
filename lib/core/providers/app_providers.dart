import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/env/env.dart';
import '../logging/app_logger.dart';
import '../network/api_client.dart';
import '../network/connectivity_service.dart';
import '../permissions/permission_service.dart';
import '../storage/preferences_service.dart';
import '../storage/secure_storage_service.dart';

part 'app_providers.g.dart';

/// Provides the resolved [SharedPreferences] instance.
///
/// This is a placeholder that MUST be overridden in `main()` after
/// `SharedPreferences.getInstance()` completes (see `main.dart`).
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('sharedPreferencesProvider must be overridden');

/// Lightweight, non-sensitive key/value preferences.
@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) =>
    PreferencesService(ref.watch(sharedPreferencesProvider));

/// Secure storage for tokens / credentials.
@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(Ref ref) => SecureStorageService();

/// Structured application logger.
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) => AppLogger();

/// Wraps `connectivity_plus`.
@Riverpod(keepAlive: true)
ConnectivityService connectivityService(Ref ref) => ConnectivityService();

/// Runtime permission checks/requests (`permission_handler`).
@Riverpod(keepAlive: true)
PermissionService permissionService(Ref ref) => const PermissionService();

/// Streams the device's online/offline status. Consumed by the UI
/// (e.g. `ConnectivityBanner`).
@riverpod
Stream<bool> connectivityStatus(Ref ref) =>
    ref.watch(connectivityServiceProvider).onStatusChange;

/// Shared HTTP client, pre-configured with the API base URL, auth-token
/// injection and logging.
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final client = ApiClient(
    baseUrl: Env.apiBaseUrl,
    secureStorage: ref.watch(secureStorageServiceProvider),
    logger: ref.watch(appLoggerProvider),
  );
  ref.onDispose(client.close);
  return client;
}
