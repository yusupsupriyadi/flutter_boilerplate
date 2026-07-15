# introduction_screen

`4.0.0` · UI · [pub.dev](https://pub.dev/packages/introduction_screen)

Prebuilt onboarding/intro carousel with pages, skip/next/done buttons, and dot indicators. Used for the first-launch flow.

**Where:** `lib/ui/features/onboarding/views/onboarding_view.dart`. Completion is persisted via `OnboardingController` → [shared_preferences](shared_preferences.md).

```dart
IntroductionScreen(
  pages: [PageViewModel(title: 'onboarding.page1_title'.tr(), ...)],
  onDone: finish,
  onSkip: finish,
  showSkipButton: true,
  next: Text('onboarding.next'.tr()),
);
```

**Note:** Copy is localized through [easy_localization](easy_localization.md). The `_StartupGate` in `app.dart` decides onboarding vs home from `onboardingControllerProvider`. See [flutter-add-introduction-screen](../../.agents/skills/flutter-add-introduction-screen) skill.
