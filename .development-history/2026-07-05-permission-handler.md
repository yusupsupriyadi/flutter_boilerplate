# 2026-07-05 — permission_handler

**Date:** 2026-07-05 (batch 3)

**Scope:** Added `permission_handler` as runtime-permission infrastructure, wired
through Riverpod, plus a project-local skill.

## Key decisions
- Added `PermissionService` (`lib/core/permissions/permission_service.dart`) as a
  thin wrapper: `status`, `isGranted`, `request`, `requestAll`, `ensureGranted`,
  `openSettings`. Exposed via `permissionServiceProvider` (`@riverpod`,
  keepAlive) in `core/providers/app_providers.dart`.
- Declared NO specific permission in native config — features request only what
  they need. The skill documents the required native steps (Android
  `<uses-permission>`, iOS `Info.plist` usage string + `PERMISSION_*` Podfile
  macro).
- No dedicated unit test: it's a pure delegation wrapper over platform channels
  (consistent with the other core service wrappers).

## Files affected
- `lib/core/permissions/permission_service.dart` (new)
- `lib/core/providers/app_providers.dart` (+ `permissionServiceProvider`)
- `.agents/skills/flutter-request-permissions/SKILL.md` (new)
- `pubspec.yaml` (+ `permission_handler: ^12.0.3`)
- Docs: `CLAUDE.md`, `README.md`

## Verification
`build_runner build`, `flutter analyze` (0 issues), `flutter test` (7/7). Not a
git repo → no commit/push.
