# package_info_plus

`10.2.1` · Platform · [pub.dev](https://pub.dev/packages/package_info_plus)

Reads app package metadata at runtime: app name, package/bundle id, version, build number, installer store, install time. All six platforms supported.

**Where:** installed dependency; not yet wired into a provider. Suggested placement: a `@riverpod` provider in `app_providers.dart`, surfaced on a Settings/About screen.

```dart
final info = await PackageInfo.fromPlatform();
info.appName;      // "Flutter Boilerplate"
info.version;      // "1.0.0"  (before "+" in pubspec version)
info.buildNumber;  // "1"      (after "+")

// suggested provider
@riverpod
Future<PackageInfo> packageInfo(Ref ref) => PackageInfo.fromPlatform();
```

**Note:** Must be called after `runApp()` (or with `WidgetsFlutterBinding.ensureInitialized()`) — calling earlier throws on Android. Values come from `version: 1.0.0+1` in `pubspec.yaml`. Native plugin → full restart, not hot reload, when first added.
