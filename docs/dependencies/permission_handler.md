# permission_handler

`12.0.3` · Platform · [pub.dev](https://pub.dev/packages/permission_handler)

Checks and requests runtime permissions (camera, location, notifications, ...) and opens the OS app-settings page.

**Where:** `lib/core/permissions/permission_service.dart` (`PermissionService`), `app_providers.dart` (`permissionServiceProvider`).

```dart
Future<bool> ensureGranted(Permission permission) async {
  if (await permission.isGranted) return true;
  final result = await permission.request();
  return result.isGranted;
}
```

**Note:** A permission is only grantable if declared natively — Android `<uses-permission>` in `AndroidManifest.xml`; iOS usage-description in `Info.plist` **and** the `PERMISSION_*` macro in `ios/Podfile`. The service declares none, so features request only what they need. See [flutter-request-permissions](../../.agents/skills/flutter-request-permissions) skill.
