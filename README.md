# flutter_boilerplate

A reusable Flutter starter template with a layered architecture, **Riverpod**
(code-generated) state management, and a set of production-ready utilities.

## What's included

| Concern | Package |
| --- | --- |
| State management & DI | `flutter_riverpod` + `riverpod_annotation` (codegen) |
| Secure token/credential storage | `flutter_secure_storage` |
| Lightweight preferences | `shared_preferences` |
| Network status | `connectivity_plus` |
| Image caching | `cached_network_image` |
| Structured logging | `logger` |
| REST networking | `http` |
| Environment config (compile-time) | `envied` |
| Localization (i18n) | `easy_localization` |
| Onboarding / intro flow | `introduction_screen` |
| App launcher icons | `flutter_launcher_icons` |
| Native splash screen | `flutter_native_splash` |
| Runtime permissions | `permission_handler` |
| Linting | `flutter_lints` + `riverpod_lint` / `custom_lint` |
| Test mocking | `mocktail` |

## Getting started

```bash
# 1. Install dependencies
flutter pub get

# 2. Create your environment file (required — .env is git-ignored)
cp .env.example .env        # then edit values as needed

# 3. Generate code (Riverpod providers + envied env class)
dart run build_runner build --delete-conflicting-outputs

# 4. (Optional) Regenerate launcher icons & native splash after swapping the
#    placeholder images in assets/icon/ and assets/splash/
dart run flutter_launcher_icons
dart run flutter_native_splash:create

# 5. Run
flutter run
```

Whenever you change a `@riverpod` provider or `.env`, re-run step 3 (or use
`dart run build_runner watch --delete-conflicting-outputs`).

## Project structure

```text
lib/
├── main.dart            # bootstrap: ProviderScope (+ overrides), runApp
├── app.dart             # root MaterialApp + theming
├── core/                # cross-cutting infrastructure
│   ├── config/env/      # envied Env (reads .env at build time)
│   ├── constants/
│   ├── network/         # ApiClient (http) + ConnectivityService
│   ├── storage/         # SecureStorageService + PreferencesService
│   ├── logging/         # AppLogger
│   ├── error/           # typed AppException hierarchy
│   ├── theme/           # AppTheme (light/dark)
│   └── providers/       # global @riverpod providers
├── data/
│   ├── models/          # API models (fromJson/toJson)
│   └── repositories/    # map API -> domain, exposed via providers
├── domain/
│   └── models/          # clean, immutable domain models
└── ui/
    ├── core/widgets/    # shared widgets (connectivity banner, error/loading)
    └── features/
        ├── onboarding/  # intro flow (introduction_screen), gated on first launch
        │   ├── view_models/
        │   └── views/
        └── photos/      # end-to-end example feature
            ├── view_models/   # @riverpod AsyncNotifier
            └── views/         # ConsumerWidget screen

assets/
├── translations/        # easy_localization JSON (en.json, id.json) — bundled
├── icon/icon.png        # flutter_launcher_icons source (build-time only)
└── splash/splash.png    # flutter_native_splash source (build-time only)
```

The `photos` feature is a full reference implementation: it fetches from a REST
API through `ApiClient` → `PhotoRepository` → a Riverpod `AsyncNotifier`, renders
the list with `cached_network_image`, and shows an offline banner driven by
`connectivity_plus`.

> Naming note: `riverpod_generator` drops a trailing `Notifier` from class names,
> so `PhotosNotifier` produces `photosProvider`.

## Environment variables

`envied` generates type-safe, optionally-obfuscated accessors from `.env` **at
build time**. Declare variables in `lib/core/config/env/env.dart`, add them to
`.env` / `.env.example`, then re-run `build_runner`. Access them via `Env.apiBaseUrl`, etc.

## Localization

Translations are JSON files in `assets/translations/` (`en.json`, `id.json`),
loaded at runtime by `easy_localization`. Use `'my.key'.tr()` in widgets. Add a
key to **every** locale file; add a locale by creating `<code>.json` and adding
the `Locale` to `supportedLocales` in `lib/main.dart`. Switch at runtime with
`context.setLocale(const Locale('id'))`.

## App icon & splash

Replace the placeholder `assets/icon/icon.png` (1024×1024) and
`assets/splash/splash.png`, then regenerate:

```bash
dart run flutter_launcher_icons        # config: flutter_launcher_icons: in pubspec.yaml
dart run flutter_native_splash:create  # config: flutter_native_splash: in pubspec.yaml
```

These write into the native platform folders (commit the results).

## Permissions

Use `PermissionService` (`permissionServiceProvider`) rather than calling
`permission_handler` directly:

```dart
final granted = await ref
    .read(permissionServiceProvider)
    .ensureGranted(Permission.camera);
```

A permission also needs native declarations: the `<uses-permission>` in
`AndroidManifest.xml`, and on iOS the `Info.plist` usage string plus the matching
`PERMISSION_*` macro in `ios/Podfile`. Declare only what you use.

## Common commands

```bash
flutter analyze                                          # static analysis + lints
dart format .                                            # format sources
flutter test                                             # run all tests
dart run custom_lint                                     # Riverpod-specific lints
flutter build apk                                        # release build (also: ios, web, ...)
```

## Conventions

Architecture and layering rules live in
`.agents/skills/flutter-apply-architecture-best-practices/SKILL.md` (and the
other `.agents/skills/`). Follow them when adding features.
