// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Presentation-logic holder for the Photos feature — the Riverpod equivalent
/// of an MVVM "ViewModel".
///
/// `build` returns a `Future`, so the generated provider exposes an
/// [AsyncValue] the View can pattern-match on (loading / data / error).

@ProviderFor(PhotosNotifier)
final photosProvider = PhotosNotifierProvider._();

/// Presentation-logic holder for the Photos feature — the Riverpod equivalent
/// of an MVVM "ViewModel".
///
/// `build` returns a `Future`, so the generated provider exposes an
/// [AsyncValue] the View can pattern-match on (loading / data / error).
final class PhotosNotifierProvider
    extends $AsyncNotifierProvider<PhotosNotifier, List<Photo>> {
  /// Presentation-logic holder for the Photos feature — the Riverpod equivalent
  /// of an MVVM "ViewModel".
  ///
  /// `build` returns a `Future`, so the generated provider exposes an
  /// [AsyncValue] the View can pattern-match on (loading / data / error).
  PhotosNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photosNotifierHash();

  @$internal
  @override
  PhotosNotifier create() => PhotosNotifier();
}

String _$photosNotifierHash() => r'9c0d01471ad0a765bbf71c912e6ae7557f3a68b1';

/// Presentation-logic holder for the Photos feature — the Riverpod equivalent
/// of an MVVM "ViewModel".
///
/// `build` returns a `Future`, so the generated provider exposes an
/// [AsyncValue] the View can pattern-match on (loading / data / error).

abstract class _$PhotosNotifier extends $AsyncNotifier<List<Photo>> {
  FutureOr<List<Photo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Photo>>, List<Photo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Photo>>, List<Photo>>,
              AsyncValue<List<Photo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
