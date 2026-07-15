# riverpod_generator

`4.0.0+1` · Codegen (dev) · [pub.dev](https://pub.dev/packages/riverpod_generator)

Generates providers from [riverpod_annotation](riverpod_annotation.md) `@riverpod` annotations, run through [build_runner](build_runner.md).

**Where:** produces the `*.g.dart` next to every annotated file (e.g. `app_providers.g.dart`, `photos_notifier.g.dart`).

```sh
dart run build_runner build --delete-conflicting-outputs
```

**Note:** Drops a trailing `Notifier` from class names — `PhotosNotifier` → `photosProvider`. Regenerate after annotation changes; `*.g.dart` is committed.
