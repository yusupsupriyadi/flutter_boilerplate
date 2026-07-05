# Conventions

- Lints: `flutter_lints ^6.0.0` via `analysis_options.yaml` (default rule set, no custom rules enabled/disabled yet).
- Dart 3.12 **dot-shorthand** syntax is used and valid — NOT typos:
  - `colorScheme: .fromSeed(...)` → `ColorScheme.fromSeed(...)`
  - `mainAxisAlignment: .center` → `MainAxisAlignment.center`
  - The `.member` type is inferred from context. Preserve this style; requires SDK/analyzer ≥ Dart 3.12.
- First-party imports use `package:flutter_boilerplate/...` (package name from pubspec).
- Standard Flutter widget conventions: `const` constructors, `super.key`, `@override` on `build`/`createState`.
- No state-management/DI/router library adopted yet — introduce deliberately, do not assume one exists.
- Serena detected `cpp` (native folders). For Dart work in `lib/`+`test/`, use built-in Read/Edit if Serena symbolic tools misbehave on Dart; touch `android/ios/linux/macos/web/windows/` only for platform config.
