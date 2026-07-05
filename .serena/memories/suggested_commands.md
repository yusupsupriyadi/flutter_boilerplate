# Suggested Commands

Dev OS: Windows (PowerShell primary). Flutter/Dart commands are identical to unix.

## Flutter
- `flutter pub get` — sync deps.
- `flutter run` / `flutter run -d chrome` — run (device: chrome/windows/linux/macos or device id).
- `flutter analyze` — static analysis + lints.
- `dart format .` — format all sources.
- `flutter test` — all tests.
- `flutter test test/widget_test.dart` — single file.
- `flutter test --name "<test name>"` — single test by name.
- `flutter build <apk|appbundle|ios|web|windows|macos|linux>` — release build.
- `flutter clean` — wipe build artifacts.

## Windows shell notes (differ from unix)
- List: `Get-ChildItem` (alias `ls`); recursive find: prefer Glob tool, not `find`.
- Content search: prefer Grep tool, not `grep`/`Select-String`.
- No git yet (`git init` first if version control needed).
