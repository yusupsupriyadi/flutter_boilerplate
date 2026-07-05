import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../view_models/onboarding_controller.dart';

/// First-launch onboarding built with `introduction_screen`. All copy is
/// localized through `easy_localization`.
class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    void finish() => ref.read(onboardingControllerProvider.notifier).complete();

    PageViewModel page(String titleKey, String bodyKey, IconData icon) {
      return PageViewModel(
        title: titleKey.tr(),
        body: bodyKey.tr(),
        image: Center(child: Icon(icon, size: 96, color: colors.primary)),
      );
    }

    return IntroductionScreen(
      pages: [
        page(
          'onboarding.page1_title',
          'onboarding.page1_body',
          Icons.rocket_launch_outlined,
        ),
        page(
          'onboarding.page2_title',
          'onboarding.page2_body',
          Icons.battery_charging_full_outlined,
        ),
        page(
          'onboarding.page3_title',
          'onboarding.page3_body',
          Icons.check_circle_outline,
        ),
      ],
      onDone: finish,
      onSkip: finish,
      showSkipButton: true,
      skip: Text('onboarding.skip'.tr()),
      next: Text('onboarding.next'.tr()),
      done: Text(
        'onboarding.done'.tr(),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: colors.primary,
        size: const Size.square(9),
        activeSize: const Size(22, 9),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
