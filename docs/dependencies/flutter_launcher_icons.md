# flutter_launcher_icons

`0.14.4` · Native asset (dev) · [pub.dev](https://pub.dev/packages/flutter_launcher_icons)

Generates platform launcher icons from a single source image. Build-time only — nothing imported at runtime.

**Where:** config in `pubspec.yaml` (`flutter_launcher_icons:`), source image `assets/icon/icon.png` (not bundled).

```sh
dart run flutter_launcher_icons
```

Config targets android, ios (`remove_alpha_ios`), web, windows, macos.

**Note:** Use a 1024×1024 source. Re-run after replacing the image; it overwrites generated native icon assets. See [flutter-generate-launcher-icons](../../.agents/skills/flutter-generate-launcher-icons) skill.
