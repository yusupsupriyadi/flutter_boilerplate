# flutter_native_splash

`2.4.8` · Native asset (dev) · [pub.dev](https://pub.dev/packages/flutter_native_splash)

Generates native splash screens for each platform from a config block. Build-time only — nothing is imported at runtime.

**Where:** config in `pubspec.yaml` (`flutter_native_splash:`), source image `assets/splash/splash.png` (not bundled).

```sh
dart run flutter_native_splash:create
```

Config: `color: "#3F51B5"`, `image: assets/splash/splash.png`, plus an `android_12` block.

**Note:** Re-run after changing the config or source image; it overwrites native project files. See [flutter-generate-native-splash](../../.agents/skills/flutter-generate-native-splash) skill.
