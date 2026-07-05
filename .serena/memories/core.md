# Core

Project: `flutter_boilerplate` — Flutter `app` scaffold from `flutter create`, currently at the default counter-demo state. Intended as a starting point; real structure (routing/state/feature folders) to be added later.

## Source map
- `lib/main.dart` — sole entry point. `main()` → `MyApp` (root `MaterialApp`+theme) → `MyHomePage` (StatefulWidget) → `_MyHomePageState` (counter via `setState`). No routing/DI/state-mgmt layer yet.
- `test/widget_test.dart` — widget smoke test; imports app as `package:flutter_boilerplate/main.dart`.
- `pubspec.yaml` — package name `flutter_boilerplate` → first-party imports use `package:flutter_boilerplate/...`.
- `analysis_options.yaml` — lints (`flutter_lints`).
- `.agents/skills/<name>/SKILL.md` — project-local Flutter skills (see below).
- Platform folders (native config only): `android/ ios/ linux/ macos/ web/ windows/`.

## Invariants
- NOT a git repository. `git` workflows assume nothing until `git init` is run.
- Serena auto-detected language as `cpp` (native folders); project is Dart-first — see `mem:conventions`.
- **Project skills** live in `.agents/skills/` (NON-standard path, not `.claude/skills/`), so they are not auto-loaded as Skill-tool entries. When a task matches (architecture, routing, localization, JSON serialization, http, responsive layout, layout-error fixing, widget preview, widget test, integration test), READ the matching `.agents/skills/<name>/SKILL.md` and follow it. Full mapping in root `CLAUDE.md` "Project Skills" section.

## Domain memories
- Stack & version pins: `mem:tech_stack`.
- Commands (dev/test/lint/build, Windows shell notes): `mem:suggested_commands`.
- Code style incl. Dart 3.12 dot-shorthand: `mem:conventions`.
- Definition-of-done checks: `mem:task_completion`.
