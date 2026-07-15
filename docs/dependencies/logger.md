# logger

`2.7.0` · Utility · [pub.dev](https://pub.dev/packages/logger)

Structured, leveled logging with pretty output. Preferred over `print`. Wrapped in `AppLogger` with a project-wide `PrettyPrinter` config.

**Where:** `lib/core/logging/app_logger.dart` (`AppLogger`), `app_providers.dart` (`appLoggerProvider`), `api_client.dart` (request/response logs).

```dart
Logger(printer: PrettyPrinter(
  methodCount: 1, errorMethodCount: 8, lineLength: 100, printEmojis: true,
));
// levels: t (trace), d (debug), i (info), w (warning), e (error)
logger.d('GET $uri');
```

**Note:** Obtain via `appLoggerProvider`, don't instantiate `Logger` directly. Consider disabling verbose output in release builds (e.g. a level filter) if log volume matters.
