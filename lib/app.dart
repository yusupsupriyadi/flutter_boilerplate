import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'ui/features/onboarding/view_models/onboarding_controller.dart';
import 'ui/features/onboarding/views/onboarding_view.dart';
import 'ui/features/photos/views/photos_view.dart';

/// Root widget: configures theming, localization delegates, and the startup
/// gate (onboarding on first launch, otherwise the home screen).
class BoilerplateApp extends ConsumerWidget {
  const BoilerplateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'app_title'.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const _StartupGate(),
    );
  }
}

/// Decides the first screen: onboarding until the user completes it, then home.
class _StartupGate extends ConsumerWidget {
  const _StartupGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingSeen = ref.watch(onboardingControllerProvider);
    return onboardingSeen ? const PhotosView() : const OnboardingView();
  }
}
