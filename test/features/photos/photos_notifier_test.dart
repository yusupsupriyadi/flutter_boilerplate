import 'dart:async';

import 'package:flutter_boilerplate/data/repositories/photo_repository.dart';
import 'package:flutter_boilerplate/domain/models/photo.dart';
import 'package:flutter_boilerplate/ui/features/photos/view_models/photos_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  late MockPhotoRepository repository;

  const photos = [Photo(id: 1, title: 'a', thumbnailUrl: 't', imageUrl: 'u')];

  setUp(() => repository = MockPhotoRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        // Inject the mocked repository into the provider graph.
        photoRepositoryProvider.overrideWithValue(repository),
      ],
      // Disable Riverpod 3's automatic retry so a failed build settles into a
      // terminal AsyncError instead of looping in a retrying-loading state.
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    return container;
  }

  /// Listens to [photosProvider] until it leaves the loading state and returns
  /// that first settled [AsyncValue]. The active listener also keeps the
  /// auto-dispose provider alive while its future resolves.
  Future<AsyncValue<List<Photo>>> firstSettled(ProviderContainer container) {
    final completer = Completer<AsyncValue<List<Photo>>>();
    final sub = container.listen<AsyncValue<List<Photo>>>(photosProvider, (
      _,
      next,
    ) {
      if (!next.isLoading && !completer.isCompleted) {
        completer.complete(next);
      }
    }, fireImmediately: true);
    return completer.future.whenComplete(sub.close);
  }

  group('PhotosNotifier', () {
    test('build emits the photos returned by the repository', () async {
      when(() => repository.getPhotos()).thenAnswer((_) async => photos);
      final container = makeContainer();

      final state = await firstSettled(container);

      expect(state.value, photos);
      verify(() => repository.getPhotos()).called(1);
    });

    test('build surfaces repository errors', () async {
      when(() => repository.getPhotos()).thenThrow(Exception('boom'));
      final container = makeContainer();

      final state = await firstSettled(container);

      expect(state.hasError, isTrue);
      expect(state.error, isA<Exception>());
    });
  });
}
