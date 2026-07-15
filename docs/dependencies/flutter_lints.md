# flutter_lints

`6.0.0` · Lint (dev) · [pub.dev](https://pub.dev/packages/flutter_lints)

Anthropic-independent recommended lint set for Flutter apps. Wired via `analysis_options.yaml`.

**Where:** `analysis_options.yaml` (`include: package:flutter_lints/flutter.yaml`), enforced by `flutter analyze`.

```sh
flutter analyze
```

**Note:** `analysis_options.yaml` also excludes `**/*.g.dart` from analysis and layers [riverpod_lint](riverpod_lint.md) on top via [custom_lint](custom_lint.md).
