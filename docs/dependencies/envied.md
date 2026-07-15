# envied

`1.3.8` · Config · [pub.dev](https://pub.dev/packages/envied)

Compile-time environment config. Reads `.env` at **build time** (not runtime) and generates a typed `_Env` class via [envied_generator](envied_generator.md). Supports obfuscation for secrets.

**Where:** `lib/core/config/env/env.dart` (`Env`), consumed in `app_providers.dart` (`Env.apiBaseUrl`).

```dart
@Envied(path: '.env', requireEnvFile: true)
abstract final class Env {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'API_KEY', obfuscate: true, defaultValue: '')
  static final String apiKey = _Env.apiKey; // obfuscated → final, not const
}
```

**Note:** Copy `.env.example` → `.env` before the first codegen run (`.env` is git-ignored). Regenerate with `dart run build_runner build --delete-conflicting-outputs` after editing `.env`. Obfuscation raises the bar but is not true secret security — don't ship high-value secrets in the client.
