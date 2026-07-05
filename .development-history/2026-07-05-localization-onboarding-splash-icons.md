# 2026-07-05 — Localization, onboarding, splash & launcher icons

**Date:** 2026-07-05 (batch 2, follows the initial boilerplate setup)

**Scope:** Added 4 packages and wired them end-to-end, plus a project-local skill
for each: `easy_localization`, `introduction_screen`, `flutter_native_splash`,
`flutter_launcher_icons`.

## Key decisions
- **Localization:** `easy_localization` (runtime JSON) is now the project's i18n
  approach; the older `flutter-setup-localization` skill (official intl/ARB) was
  annotated as the alternative. Locales: `en`, `id`. Translations in
  `assets/translations/`.
- **Onboarding:** `introduction_screen` gated on first launch via
  `OnboardingController` (`@riverpod`, `onboardingControllerProvider`) backed by
  the existing `PreferencesService.onboardingSeen`. `app.dart._StartupGate`
  chooses `OnboardingView` vs `PhotosView` — no Navigator needed.
- **Splash & icons:** `flutter_native_splash` + `flutter_launcher_icons` are
  build-time generators (dev deps), configured in `pubspec.yaml`. Placeholder
  source images generated at `assets/icon/icon.png` (1024²) and
  `assets/splash/splash.png` (via PowerShell System.Drawing). Both generators
  were run, producing native icon/splash resources across all platforms.

## Files affected (high level)
- `lib/main.dart` — EasyLocalization.ensureInitialized + EasyLocalization wrapper.
- `lib/app.dart` — localization delegates + `_StartupGate` (onboarding gate).
- `lib/ui/features/onboarding/**` — `OnboardingController` + `OnboardingView`.
- `lib/ui/features/photos/views/photos_view.dart`,
  `lib/ui/core/widgets/connectivity_banner.dart` — localized strings (`.tr()`).
- `assets/translations/en.json`, `id.json`; `assets/icon/`, `assets/splash/`.
- `pubspec.yaml` — deps, `assets:`, `flutter_launcher_icons:` &
  `flutter_native_splash:` config.
- `test/widget_test.dart` — wrapped in EasyLocalization + SharedPreferences mock.
- Native folders (`android/`, `ios/`, `macos/`, `web/`, `windows/`) — generated
  icon/splash resources.
- `.agents/skills/` — 4 new skills + cross-note on `flutter-setup-localization`.
- Docs: `CLAUDE.md`, `README.md`.

## Verification
`build_runner build`, `dart run flutter_launcher_icons`,
`dart run flutter_native_splash:create`, `flutter analyze` (0 issues),
`flutter test` (7/7 pass). Not a git repo → no commit/push.

## Notes
- `riverpod_generator` drops the `Notifier` suffix but NOT `Controller`:
  `OnboardingController` → `onboardingControllerProvider`.
- Widget tests that render `.tr()` widgets must init easy_localization
  (`SharedPreferences.setMockInitialValues({})` + `ensureInitialized()`).
