# easy_localization

`3.0.8` · i18n · [pub.dev](https://pub.dev/packages/easy_localization)

Runtime localization from JSON files. Keys resolve via the `.tr()` string extension; locale switches without a rebuild of the whole tree.

**Where:** `main.dart` (`EasyLocalization.ensureInitialized()` + `EasyLocalization` widget), `lib/app.dart` (delegates), all UI (`.tr()`), translations in `assets/translations/{en,id}.json`.

```dart
// main.dart
await EasyLocalization.ensureInitialized();
EasyLocalization(
  supportedLocales: const [Locale('en'), Locale('id')],
  path: 'assets/translations',
  fallbackLocale: const Locale('en'),
  child: const BoilerplateApp(),
);

// usage
Text('photos.title'.tr())
```

**Note:** `assets/translations/` must be declared in `pubspec.yaml` assets (it is). Add a key to **every** locale JSON. See [flutter-setup-easy-localization](../../.agents/skills/flutter-setup-easy-localization) skill.
