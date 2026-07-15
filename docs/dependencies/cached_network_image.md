# cached_network_image

`3.4.1` · UI · [pub.dev](https://pub.dev/packages/cached_network_image)

Loads and caches network images to disk/memory, with `placeholder` and `errorWidget` builders. Avoids re-downloading on rebuild/scroll.

**Where:** `lib/ui/features/photos/views/photos_view.dart` (photo thumbnails).

```dart
CachedNetworkImage(
  imageUrl: photo.thumbnailUrl,
  width: 56, height: 56, fit: BoxFit.cover,
  placeholder: (_, _) => const CircularProgressIndicator(strokeWidth: 2),
  errorWidget: (_, _, _) => const Icon(Icons.broken_image_outlined),
)
```

**Note:** Always provide `errorWidget` — network images fail. Wrap in `ClipRRect` for rounded corners (as done in `photos_view.dart`).
