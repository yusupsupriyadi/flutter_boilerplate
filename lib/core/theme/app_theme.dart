import 'package:flutter/material.dart';

/// Centralised light & dark themes.
///
/// Uses Dart 3.12 dot-shorthand syntax (`.fromSeed`, `.dark`) — the type is
/// inferred from context. Material 3 is the framework default in this SDK.
abstract final class AppTheme {
  static const Color _seedColor = Colors.indigo;

  static ThemeData get light =>
      ThemeData(colorScheme: .fromSeed(seedColor: _seedColor));

  static ThemeData get dark => ThemeData(
    colorScheme: .fromSeed(seedColor: _seedColor, brightness: .dark),
  );
}
