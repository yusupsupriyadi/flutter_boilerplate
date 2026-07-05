---
name: flutter-request-permissions
description: Check and request runtime permissions (camera, location, notifications, storage, etc.) with the `permission_handler` package, including the required native (Android/iOS) configuration. Use when a feature needs a device permission.
metadata:
  model: claude-opus-4-8
  last_modified: Sun, 05 Jul 2026 00:00:00 GMT
---
# Runtime permissions with permission_handler

## Contents
- [Dart API](#dart-api)
- [Native configuration (required)](#native-configuration-required)
- [Integration in this boilerplate](#integration-in-this-boilerplate)

## Dart API
```dart
// Check without prompting
final status = await Permission.camera.status; // PermissionStatus

// Request one
if (await Permission.camera.request().isGranted) { /* ... */ }

// Request several
final statuses = await [Permission.camera, Permission.location].request();

// React to the outcome
if (status.isPermanentlyDenied) {
  await openAppSettings(); // user must re-enable it in settings
}
```
`PermissionStatus`: `granted`, `denied`, `permanentlyDenied`, `restricted` (iOS),
`limited` (iOS14+/Android14+), `provisional` (iOS notifications). Useful getters:
`isGranted`, `isDenied`, `isPermanentlyDenied`, `isRestricted`.

## Native configuration (required)
A permission only works if declared natively:

- **Android** — add the permission(s) you use to
  `android/app/src/main/AndroidManifest.xml`, e.g.
  `<uses-permission android:name="android.permission.CAMERA"/>`.
- **iOS** — two steps:
  1. Add the usage-description string to `ios/Runner/Info.plist`
     (e.g. `NSCameraUsageDescription`).
  2. In `ios/Podfile`, enable the matching macro so only the permissions you use
     are compiled in (App Store requirement). permission_handler ships a
     `setup.rb` / `PermissionGroup` list; set e.g.
     `'PERMISSION_CAMERA=1'` in the `post_install` `GCC_PREPROCESSOR_DEFINITIONS`.

Declare only the permissions the app actually uses — over-declaring triggers
store review rejections.

## Integration in this boilerplate
Use `PermissionService` (`lib/core/permissions/permission_service.dart`) via
`permissionServiceProvider` instead of calling `permission_handler` directly:
```dart
final granted = await ref
    .read(permissionServiceProvider)
    .ensureGranted(Permission.camera);
if (!granted) {
  // show rationale, or ref.read(permissionServiceProvider).openSettings();
}
```
`PermissionService` exposes `status`, `isGranted`, `request`, `requestAll`,
`ensureGranted`, and `openSettings`. It declares no specific permission, so each
feature requests only what it needs (after adding the native entries above).
