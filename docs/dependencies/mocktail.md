# mocktail

`1.0.5` · Test (dev) · [pub.dev](https://pub.dev/packages/mocktail)

Codegen-free mocking (no `build_runner` step, unlike `mockito`). Create mocks by extending `Mock` and implementing the target type.

**Where:** `test/features/photos/photos_notifier_test.dart`, `test/widget_test.dart`.

```dart
class MockPhotoRepository extends Mock implements PhotoRepository {}

when(() => repository.getPhotos()).thenAnswer((_) async => photos);
verify(() => repository.getPhotos()).called(1);
```

**Note:** Uses closures — `when(() => ...)`, not `when(...)`. Mocks are injected into Riverpod via `ProviderContainer` overrides. Register fallbacks with `registerFallbackValue` for custom argument types.
