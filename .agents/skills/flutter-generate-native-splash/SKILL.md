---
name: flutter-generate-native-splash
description: Generate native splash screens (Android incl. Android 12+, iOS, web) with the `flutter_native_splash` package via pubspec config + a CLI generator. Use when setting up or changing the launch/splash screen.
metadata:
  model: claude-opus-4-8
  last_modified: Sun, 05 Jul 2026 00:00:00 GMT
---
# Native splash screen with flutter_native_splash

`flutter_native_splash` is a **build-time generator** (a `dev_dependency`). It
writes native splash resources from a config block; there is no runtime Dart API.

## Contents
- [Configure](#configure)
- [Generate](#generate)
- [Notes](#notes)

## Configure
Add a top-level `flutter_native_splash:` block to `pubspec.yaml` (or a separate
`flutter_native_splash.yaml`). Minimum = a background `color` (or
`background_image`) plus a centered `image` logo (PNG, sized ~4x density):
```yaml
flutter_native_splash:
  color: "#3F51B5"            # REQUIRED (mutually exclusive with background_image)
  image: assets/splash/splash.png
  # color_dark / image_dark for dark mode
  android_12:                 # Android 12+ handles splash separately
    color: "#3F51B5"
    image: assets/splash/splash.png
    # icon_background_color: "#ffffff"
```
The splash source image lives under `assets/` but does NOT need to be listed in
`flutter: assets:` (it is consumed at build time, not loaded at runtime).

## Generate
```bash
dart run flutter_native_splash:create      # generate
dart run flutter_native_splash:remove      # revert to the default white splash
```
Re-run `:create` after changing the config or the source image. If results look
stale: `flutter clean && flutter pub get`, then regenerate.

## Notes
- Commit the generated native files (they are part of each platform project).
- Android 12+ shows an icon-style splash — keep the logo simple and centered.
- Pair with `flutter-generate-launcher-icons` for a consistent brand image; both
  read source images from `assets/`.
