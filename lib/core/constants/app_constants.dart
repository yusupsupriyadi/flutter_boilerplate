/// App-wide constant values that are not environment-specific.
///
/// Environment-specific values (base URL, API keys) live in `Env`
/// (see `core/config/env/env.dart`), not here.
abstract final class AppConstants {
  static const String appName = 'Flutter Boilerplate';

  /// Default page size for paginated list requests.
  static const int defaultPageSize = 20;

  /// Default network timeout.
  static const Duration networkTimeout = Duration(seconds: 30);
}
