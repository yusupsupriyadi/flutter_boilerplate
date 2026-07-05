import 'package:permission_handler/permission_handler.dart';

/// Wraps `permission_handler` for runtime permission checks and requests.
///
/// IMPORTANT: A permission can only be granted if it is also declared natively:
/// - Android: add the matching `<uses-permission>` to `AndroidManifest.xml`.
/// - iOS: add the usage-description string to `Info.plist` and enable the
///   corresponding `PERMISSION_*` macro in `ios/Podfile`.
/// This service intentionally declares no specific permission so features can
/// request only what they need.
class PermissionService {
  const PermissionService();

  /// Current status of [permission] without prompting the user.
  Future<PermissionStatus> status(Permission permission) => permission.status;

  /// Whether [permission] is currently granted.
  Future<bool> isGranted(Permission permission) => permission.isGranted;

  /// Prompts the user for [permission] and returns the resulting status.
  Future<PermissionStatus> request(Permission permission) =>
      permission.request();

  /// Prompts for several [permissions] at once.
  Future<Map<Permission, PermissionStatus>> requestAll(
    List<Permission> permissions,
  ) => permissions.request();

  /// Ensures [permission] is granted, requesting it if needed. Returns whether
  /// it ended up granted.
  Future<bool> ensureGranted(Permission permission) async {
    if (await permission.isGranted) return true;
    final result = await permission.request();
    return result.isGranted;
  }

  /// Opens the OS app-settings page. Use this when a permission is
  /// permanently denied and can only be re-enabled from settings.
  Future<bool> openSettings() => openAppSettings();
}
