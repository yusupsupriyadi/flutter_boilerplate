# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`flutter_boilerplate` is a reusable Flutter application template (project type `app`). It ships a layered architecture (UI / Domain / Data + `core/`) with **Riverpod** (code-generated) for state management and dependency injection, plus ready-made utilities: secure storage, `shared_preferences`, connectivity detection, cached network images, structured logging, `http` networking, and compile-time environment config via **envied**. An end-to-end example feature (`lib/ui/features/photos/`) demonstrates the full stack.

New features should follow the existing layering (see the `flutter-apply-architecture-best-practices` skill) rather than reverting to a flat scaffold.

Targets all six Flutter platforms: `android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`.

## Project Skills (`.agents/skills/`)

This repo ships **project-local Flutter skills** under `.agents/skills/<name>/SKILL.md`. They live outside the standard `.claude/skills/` path, so they are **not** auto-loaded as `Skill`-tool entries — when a task matches one, **read that skill's `SKILL.md` and follow it** before implementing. Use them whenever the work fits; do not reinvent the workflow they already document.

| Skill (`.agents/skills/…`) | Use when |
| --- | --- |
| `flutter-apply-architecture-best-practices` | Structuring a new feature/project or refactoring into layered UI / Logic / Data. |
| `flutter-setup-declarative-routing` | Adding navigation, deep links, or URL-based routing (`go_router`, `MaterialApp.router`). |
| `flutter-setup-easy-localization` | **(used here)** Runtime i18n with `easy_localization` (JSON translations, `.tr()`). |
| `flutter-setup-localization` | Alternative official i18n (`flutter_localizations` + `intl` + ARB codegen). |
| `flutter-implement-json-serialization` | Writing model classes with `fromJson`/`toJson` via `dart:convert`. |
| `flutter-use-http-package` | Calling a REST API (GET/POST/PUT/DELETE) with the `http` package. |
| `flutter-build-responsive-layout` | Making UI adapt across mobile/tablet/desktop (`LayoutBuilder`, `MediaQuery`, `Expanded/Flexible`). |
| `flutter-fix-layout-issues` | Debugging `RenderFlex overflowed`, unbounded-constraint, or similar layout errors. |
| `flutter-add-widget-preview` | Adding interactive widget previews (`previews.dart`) for new/updated UI. |
| `flutter-add-widget-test` | Writing component-level `WidgetTester` tests (render + tap/scroll/text interactions). |
| `flutter-add-integration-test` | Adding end-to-end flows with the `integration_test` package / Flutter Driver. |
| `flutter-add-introduction-screen` | First-launch onboarding / intro flow (`introduction_screen`). |
| `flutter-generate-launcher-icons` | Generating app launcher icons (`flutter_launcher_icons`). |
| `flutter-generate-native-splash` | Generating native splash screens (`flutter_native_splash`). |
| `flutter-request-permissions` | Requesting/checking runtime permissions (`permission_handler`). |

## Toolchain

- Flutter `3.44.4` / Dart SDK `3.12.2`, stable channel (constraint in `pubspec.yaml`: `sdk: ^3.12.2`).
- Lints: `flutter_lints ^6.0.0` + `riverpod_lint`/`custom_lint`, wired through `analysis_options.yaml` (which also excludes `**/*.g.dart`).
- State management & DI: `flutter_riverpod` + `riverpod_annotation`, using code generation (`riverpod_generator`).
- Code generation: `build_runner` produces `*.g.dart` for Riverpod providers and the `envied` env class. Run `dart run build_runner build --delete-conflicting-outputs` after changing providers or `.env`. Generated files are committed.
- Env config: `envied` reads `.env` at **build time** (not runtime). Copy `.env.example` → `.env` before the first codegen run; `.env` is git-ignored, `.env.example` is tracked.
- Utilities: `flutter_secure_storage`, `shared_preferences`, `connectivity_plus`, `cached_network_image`, `logger`, `http`, `permission_handler`; `mocktail` for test mocks.
- Localization: `easy_localization` (runtime JSON in `assets/translations/`, `.tr()`); onboarding via `introduction_screen`.
- Native assets (build-time generators, dev deps): `flutter_launcher_icons` (`dart run flutter_launcher_icons`) and `flutter_native_splash` (`dart run flutter_native_splash:create`). Config lives in `pubspec.yaml`; source images in `assets/icon/` and `assets/splash/` are build-time only (not bundled).
- The repository is **not** a git repository. Do not assume git is available; the auto-commit/push workflow in the global CLAUDE.md does not apply here unless `git init` has been run first.

## Dependency Docs (`docs/dependencies/`)

Per-package docs live in `docs/dependencies/`: one `.md` per dependency (resolved version, why it's used here, where, and a real snippet from the codebase) plus `README.md` as the index. Consult these before adding, upgrading, or wiring a package. When adding a new dependency, add a matching `docs/dependencies/<package>.md` and a row in the index.

## Dart 3.12 dot-shorthand syntax

This codebase uses Dart 3.12 **dot-shorthand** syntax (e.g. `lib/core/theme/app_theme.dart`, `lib/ui/`), where the type before a `.member` is inferred from context. This is intentional and valid — not a typo or missing identifier:

- `colorScheme: .fromSeed(seedColor: ...)` → resolves to `ColorScheme.fromSeed(...)`
- `mainAxisAlignment: .center` → resolves to `MainAxisAlignment.center`

Preserve this style when editing existing code; the project SDK supports it. Older analyzers/tooling that predate Dart 3.12 will flag these as errors, so ensure any tooling matches the pinned SDK.

## Common Commands

```bash
flutter pub get                 # install/sync dependencies
flutter run                     # run on the default connected device
flutter run -d chrome           # run on web (also: windows, linux, macos, or a device id)
flutter analyze                 # static analysis + lints (analysis_options.yaml)
dart format .                   # format all Dart sources
flutter test                    # run all tests
dart run build_runner build --delete-conflicting-outputs # regenerate *.g.dart (Riverpod + envied)
dart run build_runner watch --delete-conflicting-outputs # regenerate on file changes
dart run flutter_launcher_icons                          # regenerate launcher icons (pubspec config)
dart run flutter_native_splash:create                    # regenerate native splash (pubspec config)
flutter test test/widget_test.dart                       # run a single test file
flutter test --name "PhotosView"                         # run tests matching a name
flutter build apk               # release build (also: appbundle, ios, web, windows, macos, linux)
flutter clean                   # wipe build artifacts when builds go stale
```

## Architecture

The app follows a layered architecture wired together with Riverpod:

- `lib/main.dart` — bootstrap: `EasyLocalization.ensureInitialized()`, resolves async singletons (e.g. `SharedPreferences`), wraps the app in a `ProviderScope` (overriding `sharedPreferencesProvider`) and `EasyLocalization`, then runs `BoilerplateApp`.
- `lib/app.dart` — `BoilerplateApp` (`ConsumerWidget`): `MaterialApp` + theming + localization delegates. `_StartupGate` shows onboarding on first launch (via `onboardingControllerProvider`), otherwise the home screen.
- `lib/core/` — cross-cutting infrastructure: `config/env` (envied), `network` (`ApiClient` over `http` + `ConnectivityService`), `storage` (secure storage + prefs wrappers), `permissions` (`PermissionService`), `logging`, `error`, `theme`, and `providers/app_providers.dart` (global `@riverpod` providers).
- `lib/data/` — `models/` (API models with manual `fromJson`/`toJson`), `repositories/` (map API → domain, exposed via providers), `services/`.
- `lib/domain/models/` — clean, immutable domain models.
- `lib/ui/` — `core/widgets/` (shared widgets) and `features/<name>/{view_models,views}/`: notifiers (`@riverpod` `Notifier`/`AsyncNotifier`) plus `ConsumerWidget` screens. `features/onboarding/` (intro flow) and `features/photos/` (networking) are the reference examples.

Note: `riverpod_generator` drops a trailing `Notifier` from class names — `PhotosNotifier` generates `photosProvider` (not `photosNotifierProvider`).

Tests and all first-party imports use the `package:flutter_boilerplate/...` prefix (the package name from `pubspec.yaml`, `name: flutter_boilerplate`).

## Serena

Serena auto-detected the language as `cpp` because of the native platform folders. When doing **Dart/Flutter** code work, this project is Dart-first — prefer the built-in Read/Edit tools for `lib/` and `test/` if Serena's symbolic tools misbehave on Dart, and reserve native-folder edits (`android/`, `ios/`, etc.) for platform configuration only.
