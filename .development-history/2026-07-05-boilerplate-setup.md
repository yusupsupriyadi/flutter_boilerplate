# 2026-07-05 — Boilerplate setup (Riverpod + core utilities)

**Date:** 2026-07-05

**Scope:** Converted the default `flutter create` counter scaffold into a
reusable template: layered architecture (core / data / domain / ui) with
Riverpod (code-generated) state management + DI, plus the requested utility
stack and an end-to-end example feature.

## Key decisions
- **State management:** Riverpod 3.x with **code generation** (`@riverpod`,
  `riverpod_generator`). This overrides the repo's architecture skill, which
  originally taught ChangeNotifier/MVVM — the skill was rewritten to Riverpod
  per user request.
- **Env:** `envied` (compile-time, obfuscation) over dotenv. Reads `.env` at
  build time; `.env` git-ignored, `.env.example` tracked.
- **HTTP:** `http` package (per repo skill), wrapped in `ApiClient` with
  Bearer-token injection from secure storage + logging.
- Generator quirk: `riverpod_generator` drops a trailing `Notifier` →
  `PhotosNotifier` produces `photosProvider`.
- Riverpod 3 auto-retries failed providers (state = `AsyncLoading` carrying the
  error). Tests disable it via `ProviderContainer(retry: (_, _) => null)`.

## Files affected (high level)
- `lib/core/**` — env (envied), constants, theme, logging (`AppLogger`),
  network (`ApiClient` over http, `ConnectivityService`), storage
  (`SecureStorageService`, `PreferencesService`), `error/app_exception.dart`,
  `providers/app_providers.dart` (global `@riverpod` providers).
- `lib/data/**`, `lib/domain/**` — `PhotoApiModel` (manual JSON), domain `Photo`,
  `PhotoRepository` (+ provider).
- `lib/ui/**` — shared widgets (connectivity banner, error/loading), `photos`
  feature (`PhotosNotifier` AsyncNotifier + `PhotosView` ConsumerWidget).
- `lib/main.dart` / `lib/app.dart` — ProviderScope bootstrap + `BoilerplateApp`.
- Config: `.env`, `.env.example`, `.gitignore` (ignore `.env`),
  `analysis_options.yaml` (custom_lint plugin + exclude `*.g.dart`),
  `android/.../AndroidManifest.xml` (INTERNET), macOS entitlements (network client).
- Tests: `test/data/models/photo_api_model_test.dart`,
  `test/features/photos/photos_notifier_test.dart` (mocktail + overrides),
  `test/widget_test.dart` (rewritten from counter smoke test).
- Docs/skills: rewrote `flutter-apply-architecture-best-practices` to Riverpod;
  added integration notes to http/json/routing skills; updated `CLAUDE.md`,
  `README.md`.

## Verification
`dart run build_runner build`, `flutter analyze` (0 issues), `dart format .`,
`flutter test` (7/7 pass). Not a git repo → no commit/push.

## Next steps (optional)
- Add routing (`go_router`) and localization when a feature needs them (skills
  exist; not enabled by default).
- Consider multi-environment `.env.dev/.env.prod` + build flavors if required.
