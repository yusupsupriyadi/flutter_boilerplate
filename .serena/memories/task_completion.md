# Task Completion

Run before considering a Dart/Flutter coding task done:
1. `dart format .` — format.
2. `flutter analyze` — must be clean (no errors/lints).
3. `flutter test` — all tests pass (or the affected `flutter test <file>`).

For platform/build-affecting changes, additionally verify `flutter build <target>` succeeds.

No git repo → no auto-commit/push step applies here (per global CLAUDE.md) unless `git init` has been done.
