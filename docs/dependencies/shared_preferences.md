# shared_preferences

`2.5.5` · Storage · [pub.dev](https://pub.dev/packages/shared_preferences)

Lightweight persistent key/value store for non-sensitive data (theme mode, onboarding flag). Sensitive data goes to [flutter_secure_storage](flutter_secure_storage.md).

**Where:** `lib/core/storage/preferences_service.dart` (`PreferencesService`), `main.dart` (resolved once at startup), `app_providers.dart` (`sharedPreferencesProvider` placeholder, overridden in `main()`).

```dart
// main.dart — resolve async, inject sync
final prefs = await SharedPreferences.getInstance();
runApp(ProviderScope(
  overrides: [sharedPreferencesProvider.overrideWithValue(prefs)], ...));

// preferences_service.dart
bool get onboardingSeen => _prefs.getBool(_onboardingSeenKey) ?? false;
```

**Note:** `sharedPreferencesProvider` throws `UnimplementedError` until overridden — the async instance must be resolved before `runApp`.
