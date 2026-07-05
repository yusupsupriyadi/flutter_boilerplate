import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/app_providers.dart';

part 'onboarding_controller.g.dart';

/// Tracks whether the user has finished onboarding, persisted via
/// [PreferencesService]. Exposed as `onboardingControllerProvider`.
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  bool build() => ref.watch(preferencesServiceProvider).onboardingSeen;

  /// Marks onboarding as complete and persists the flag.
  Future<void> complete() async {
    await ref.read(preferencesServiceProvider).setOnboardingSeen(value: true);
    state = true;
  }
}
