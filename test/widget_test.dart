// Widget test for the Photos example screen.
//
// It overrides `photoRepositoryProvider` with a mocktail mock so the widget
// tree renders without touching the network, and wraps the tree in
// `EasyLocalization` so `.tr()` calls resolve against the bundled translations.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/data/repositories/photo_repository.dart';
import 'package:flutter_boilerplate/domain/models/photo.dart';
import 'package:flutter_boilerplate/ui/features/photos/views/photos_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  setUpAll(() async {
    // easy_localization persists the selected locale via shared_preferences.
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('PhotosView shows its app bar once data resolves', (
    tester,
  ) async {
    final repository = MockPhotoRepository();
    // Return an empty list to avoid building network images in the test.
    when(() => repository.getPhotos()).thenAnswer((_) async => const <Photo>[]);

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: ProviderScope(
          overrides: [photoRepositoryProvider.overrideWithValue(repository)],
          child: const _TestApp(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Photos'), findsOneWidget);
    expect(find.byType(ErrorWidget), findsNothing);
    verify(() => repository.getPhotos()).called(1);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const PhotosView(),
    );
  }
}
