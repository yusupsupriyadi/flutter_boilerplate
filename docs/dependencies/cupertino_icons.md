# cupertino_icons

`1.0.9` · UI · [pub.dev](https://pub.dev/packages/cupertino_icons)

iOS-style icon font backing the `CupertinoIcons` class. Default Flutter dependency.

**Where:** available app-wide; no direct import yet (the app uses Material `Icons.*`). Kept for iOS-style icons when needed.

```dart
Icon(CupertinoIcons.heart_fill)
```

**Note:** Only ships glyphs — for full Cupertino widgets use the `flutter/cupertino.dart` library. Safe to remove if the app stays Material-only, but it's a tiny, conventional default.
