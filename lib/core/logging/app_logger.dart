import 'package:logger/logger.dart';

/// Thin wrapper around the `logger` package with a project-wide default config.
///
/// Prefer this over `print`. Obtain the shared instance through
/// `appLoggerProvider` (see `core/providers/app_providers.dart`).
class AppLogger {
  AppLogger({Logger? logger})
    : _logger =
          logger ??
          Logger(
            printer: PrettyPrinter(
              methodCount: 1,
              errorMethodCount: 8,
              lineLength: 100,
              printEmojis: true,
            ),
          );

  final Logger _logger;

  void t(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.t(message, error: error, stackTrace: stackTrace);

  void d(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  void i(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  void w(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  void e(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
