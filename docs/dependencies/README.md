# Dependencies

Per-package docs for `flutter_boilerplate`, scoped to **this repo**: why it's used, where, and a real snippet from the codebase.

Versions are the resolved values from `pubspec.lock` (`pubspec.yaml` uses `^`). Refresh after `flutter pub upgrade`.

## Runtime

| Package | Version | Category | Summary |
| --- | --- | --- | --- |
| [flutter_riverpod](flutter_riverpod.md) | 3.1.0 | State & DI | State management + dependency injection |
| [riverpod_annotation](riverpod_annotation.md) | 4.0.0 | State & DI | `@riverpod` annotations for provider codegen |
| [flutter_secure_storage](flutter_secure_storage.md) | 10.3.1 | Storage | Encrypted storage (tokens/credentials) |
| [shared_preferences](shared_preferences.md) | 2.5.5 | Storage | Lightweight non-sensitive key/value |
| [connectivity_plus](connectivity_plus.md) | 7.2.0 | Network | Online/offline detection |
| [http](http.md) | 1.6.0 | Network | REST client (`ApiClient` base) |
| [cached_network_image](cached_network_image.md) | 3.4.1 | UI | Cached network images + placeholders |
| [easy_localization](easy_localization.md) | 3.0.8 | i18n | Runtime JSON translations (`.tr()`) |
| [introduction_screen](introduction_screen.md) | 4.0.0 | UI | First-launch onboarding flow |
| [permission_handler](permission_handler.md) | 12.0.3 | Platform | Runtime permissions |
| [package_info_plus](package_info_plus.md) | 10.2.1 | Platform | App package info (version, build) |
| [logger](logger.md) | 2.7.0 | Utility | Structured logging |
| [envied](envied.md) | 1.3.8 | Config | Compile-time env config from `.env` |
| [cupertino_icons](cupertino_icons.md) | 1.0.9 | UI | iOS-style icon font |

## Dev

| Package | Version | Category | Summary |
| --- | --- | --- | --- |
| [build_runner](build_runner.md) | 2.15.0 | Codegen | Runner for all `*.g.dart` generators |
| [riverpod_generator](riverpod_generator.md) | 4.0.0+1 | Codegen | Generates providers from `@riverpod` |
| [envied_generator](envied_generator.md) | 1.3.8 | Codegen | Generates `_Env` from `@Envied` |
| [flutter_lints](flutter_lints.md) | 6.0.0 | Lint | Recommended Flutter lint set |
| [riverpod_lint](riverpod_lint.md) | 3.1.0 | Lint | Riverpod-specific lints + assists |
| [custom_lint](custom_lint.md) | 0.8.1 | Lint | Engine that runs `riverpod_lint` |
| [mocktail](mocktail.md) | 1.0.5 | Test | Codegen-free mocks for unit tests |
| [package_rename](package_rename.md) | 1.10.1 | Native asset | Renames app name + bundle id across platforms |
| [flutter_native_splash](flutter_native_splash.md) | 2.4.8 | Native asset | Generates native splash screens |
| [flutter_launcher_icons](flutter_launcher_icons.md) | 0.14.4 | Native asset | Generates launcher icons |

## Codegen

Annotated packages (`riverpod_annotation`, `envied`) must be regenerated after edits:

```sh
dart run build_runner build --delete-conflicting-outputs
```

`*.g.dart` files are committed.
