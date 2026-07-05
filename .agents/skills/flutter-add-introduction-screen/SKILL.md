---
name: flutter-add-introduction-screen
description: Build a first-launch onboarding / intro flow with the `introduction_screen` package (`IntroductionScreen` + `PageViewModel`). Use when adding walkthrough or welcome screens.
metadata:
  model: claude-opus-4-8
  last_modified: Sun, 05 Jul 2026 00:00:00 GMT
---
# Onboarding with introduction_screen

## Contents
- [Core widgets](#core-widgets)
- [First-launch gating (Riverpod)](#first-launch-gating-riverpod)
- [Example](#example)

## Core widgets
- **`IntroductionScreen`**: hosts the pages plus skip/next/done controls and the
  dots indicator. Key params: `pages`, `onDone`, `onSkip`, `showSkipButton`,
  `skip`, `next`, `done`, `dotsDecorator`.
- **`PageViewModel`**: one page — `title`, `body`, `image` (any widget),
  optional `decoration` (`PageDecoration`), `titleWidget`/`bodyWidget`.

## First-launch gating (Riverpod)
Persist a "seen" flag (via `PreferencesService` / `shared_preferences`) and gate
the home screen on it. In this boilerplate:
- `PreferencesService.onboardingSeen` / `setOnboardingSeen(...)` store the flag.
- `OnboardingController` (`@riverpod`, in `ui/features/onboarding/view_models/`)
  exposes it as `onboardingControllerProvider` with a `complete()` command.
- `app.dart`'s `_StartupGate` watches it: `seen ? PhotosView() : OnboardingView()`.
  Calling `complete()` flips the flag and the gate rebuilds — no `Navigator` push
  needed.

Localize all copy with `easy_localization` (`'onboarding.page1_title'.tr()`).

## Example
```dart
class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void finish() => ref.read(onboardingControllerProvider.notifier).complete();
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'onboarding.page1_title'.tr(),
          body: 'onboarding.page1_body'.tr(),
          image: const Center(child: Icon(Icons.rocket_launch_outlined, size: 96)),
        ),
        // ...more pages
      ],
      onDone: finish,
      onSkip: finish,
      showSkipButton: true,
      skip: Text('onboarding.skip'.tr()),
      next: Text('onboarding.next'.tr()),
      done: Text('onboarding.done'.tr()),
      dotsDecorator: DotsDecorator(activeColor: Theme.of(context).colorScheme.primary),
    );
  }
}
```
