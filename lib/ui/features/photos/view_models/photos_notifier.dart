import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/photo_repository.dart';
import '../../../../domain/models/photo.dart';

part 'photos_notifier.g.dart';

/// Presentation-logic holder for the Photos feature — the Riverpod equivalent
/// of an MVVM "ViewModel".
///
/// `build` returns a `Future`, so the generated provider exposes an
/// [AsyncValue] the View can pattern-match on (loading / data / error).
@riverpod
class PhotosNotifier extends _$PhotosNotifier {
  @override
  Future<List<Photo>> build() {
    return ref.watch(photoRepositoryProvider).getPhotos();
  }

  /// Re-fetches the list, surfacing loading and error states to the UI.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(photoRepositoryProvider).getPhotos(),
    );
  }
}
