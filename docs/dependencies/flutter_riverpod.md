# flutter_riverpod

`3.1.0` · State & DI · [pub.dev](https://pub.dev/packages/flutter_riverpod)

Reactive state management + dependency injection. Every service (`ApiClient`, storage, logger) is provided through the graph instead of global singletons; async singletons are resolved once in `main()` and injected via overrides.

**Where:** `lib/main.dart` (`ProviderScope` + override), `lib/core/providers/app_providers.dart` (global providers), `lib/ui/**` (`ConsumerWidget`), tests (`ProviderContainer` + overrides).

```dart
// main.dart
runApp(ProviderScope(
  overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  child: const BoilerplateApp(),
));

// photos_view.dart
final photosAsync = ref.watch(photosProvider);
```

**Note:** Used with codegen via [riverpod_annotation](riverpod_annotation.md) + [riverpod_generator](riverpod_generator.md). Riverpod 3 auto-retries failed providers; tests disable it with `retry: (_, _) => null`.
