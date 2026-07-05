import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';

/// A slim banner that appears when the device goes offline.
///
/// Watches `connectivityStatusProvider`; the banner is shown only when the
/// stream has emitted `false` (offline), and stays hidden while loading.
class ConnectivityBanner extends ConsumerWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(connectivityStatusProvider).value == false;
    final colors = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: isOffline
          ? Material(
              color: colors.errorContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      size: 16,
                      color: colors.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'photos.offline'.tr(),
                      style: TextStyle(color: colors.onErrorContainer),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
