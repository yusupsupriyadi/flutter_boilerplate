---
name: flutter-generate-launcher-icons
description: Generate app launcher icons for all platforms (Android, iOS, web, Windows, macOS) from one source image with the `flutter_launcher_icons` package via pubspec config + a CLI generator. Use when setting or changing the app icon.
metadata:
  model: claude-opus-4-8
  last_modified: Sun, 05 Jul 2026 00:00:00 GMT
---
# Launcher icons with flutter_launcher_icons

`flutter_launcher_icons` is a **build-time generator** (a `dev_dependency`). It
produces per-platform icon sets from a single source PNG; no runtime Dart API.

## Contents
- [Configure](#configure)
- [Generate](#generate)
- [Notes](#notes)

## Configure
Provide a square source image (ideally **1024x1024** PNG) and add a top-level
`flutter_launcher_icons:` block to `pubspec.yaml`:
```yaml
flutter_launcher_icons:
  image_path: "assets/icon/icon.png"
  android: true          # true overwrites the default ic_launcher; or a "custom_name"
  ios: true
  remove_alpha_ios: true # iOS icons must not have an alpha channel
  min_sdk_android: 21
  web:
    generate: true
    image_path: "assets/icon/icon.png"
    background_color: "#3F51B5"
    theme_color: "#3F51B5"
  windows:
    generate: true
    image_path: "assets/icon/icon.png"
    icon_size: 48        # 48..256
  macos:
    generate: true
    image_path: "assets/icon/icon.png"
```
The source image lives under `assets/` but does NOT need to be listed in
`flutter: assets:` (consumed at build time, not loaded at runtime).

## Generate
```bash
dart run flutter_launcher_icons
```
Re-run after replacing the source image or changing config.

## Notes
- If `android:` is a custom string, reference `@mipmap/<name>` in
  `AndroidManifest.xml`; `android: true` overwrites the default `ic_launcher`.
- Commit the generated native icon files.
- For adaptive Android icons, add `adaptive_icon_background` /
  `adaptive_icon_foreground`.
- Pair with `flutter-generate-native-splash` for a consistent brand image.
