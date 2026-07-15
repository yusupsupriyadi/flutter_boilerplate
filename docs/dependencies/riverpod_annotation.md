# riverpod_annotation

`4.0.0` · State & DI (codegen) · [pub.dev](https://pub.dev/packages/riverpod_annotation)

Provides `@riverpod` / `@Riverpod(...)` annotations consumed by [riverpod_generator](riverpod_generator.md). Provider type is inferred from the function/class signature, so no provider is hand-written. `keepAlive: true` marks app-lifetime singletons.

**Where:** `lib/core/providers/app_providers.dart`, `lib/ui/features/*/view_models/*`, `lib/data/repositories/photo_repository.dart`.

```dart
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) => AppLogger();

@riverpod
class PhotosNotifier extends _$PhotosNotifier {
  @override
  Future<List<Photo>> build() => ref.watch(photoRepositoryProvider).getPhotos();
}
```

**Note:** The generator **drops** a trailing `Notifier` — `PhotosNotifier` → `photosProvider`. Run `dart run build_runner build --delete-conflicting-outputs` after edits.
