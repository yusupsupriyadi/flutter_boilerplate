---
name: flutter-setup-easy-localization
description: Set up runtime internationalization with the `easy_localization` package (JSON translation files, `.tr()`, locale switching). Use when adding or extending i18n in this boilerplate — this is the localization approach the project actually uses.
metadata:
  model: claude-opus-4-8
  last_modified: Sun, 05 Jul 2026 00:00:00 GMT
---
# Localization with easy_localization

> This boilerplate uses **easy_localization** (JSON, runtime) for i18n. The
> `flutter-setup-localization` skill documents the alternative official
> `flutter_localizations` + `intl` + ARB approach — do not mix the two.

## Contents
- [Setup](#setup)
- [Usage](#usage)
- [Adding a language or key](#adding-a-language-or-key)

## Setup

1. Dependency: `flutter pub add easy_localization` (pulls in `flutter_localizations`).
2. Translation files live in `assets/translations/<locale>.json` (e.g. `en.json`,
   `id.json`) and MUST be declared as an asset in `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/translations/
   ```
3. Initialize before `runApp` and wrap the app. Keep `ProviderScope` outermost so
   providers are available; `EasyLocalization` wraps the `MaterialApp`:
   ```dart
   Future<void> main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await EasyLocalization.ensureInitialized();
     runApp(
       ProviderScope(
         child: EasyLocalization(
           supportedLocales: const [Locale('en'), Locale('id')],
           path: 'assets/translations',
           fallbackLocale: const Locale('en'),
           child: const BoilerplateApp(),
         ),
       ),
     );
   }
   ```
4. Wire the delegates into `MaterialApp` (in `app.dart`):
   ```dart
   MaterialApp(
     localizationsDelegates: context.localizationDelegates,
     supportedLocales: context.supportedLocales,
     locale: context.locale,
     // ...
   );
   ```

## Usage

- Translate with the `String` extension: `Text('photos.title'.tr())`, or
  `context.tr('photos.title')`. Nested JSON keys use dot paths.
- Plurals: `'items'.plural(count)`. Named args: `'hello'.tr(namedArgs: {'name': n})`.
- Change locale at runtime: `context.setLocale(const Locale('id'))`.

## Adding a language or key

1. Add the key to **every** `assets/translations/<locale>.json` (keep them in sync).
2. To add a locale, create `assets/translations/<code>.json` and add the `Locale`
   to `supportedLocales` in `main.dart`.
3. No codegen needed — files load at runtime. Hot restart to pick up changes.

## Testing localized widgets
In widget tests, mock prefs and initialize before pumping, then wrap the tree:
```dart
setUpAll(() async {
  SharedPreferences.setMockInitialValues({});      // easy_localization persists locale
  await EasyLocalization.ensureInitialized();
});
// pump: EasyLocalization(... child: ProviderScope(... MaterialApp(...))) then pumpAndSettle()
```
