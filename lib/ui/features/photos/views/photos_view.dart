import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/connectivity_banner.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../view_models/photos_notifier.dart';

/// End-to-end example screen wiring together every boilerplate utility:
/// `http` (via ApiClient) -> repository -> Riverpod `AsyncNotifier` ->
/// `cached_network_image` -> connectivity banner.
///
/// Note: the generated provider for `PhotosNotifier` is `photosProvider`
/// (riverpod_generator drops the `Notifier` suffix).
class PhotosView extends ConsumerWidget {
  const PhotosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photosProvider);

    return Scaffold(
      appBar: AppBar(title: Text('photos.title'.tr())),
      body: Column(
        children: [
          const ConnectivityBanner(),
          Expanded(
            child: switch (photosAsync) {
              AsyncData(:final value) => RefreshIndicator(
                onRefresh: () => ref.read(photosProvider.notifier).refresh(),
                child: ListView.separated(
                  itemCount: value.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final photo = value[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: photo.thumbnailUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => const SizedBox.square(
                            dimension: 56,
                            child: Center(
                              child: SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (_, _, _) =>
                              const Icon(Icons.broken_image_outlined),
                        ),
                      ),
                      title: Text(
                        photo.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text('#${photo.id}'),
                    );
                  },
                ),
              ),
              AsyncError(:final error) => ErrorView(
                message: error.toString(),
                onRetry: () => ref.read(photosProvider.notifier).refresh(),
              ),
              _ => const LoadingView(),
            },
          ),
        ],
      ),
    );
  }
}
