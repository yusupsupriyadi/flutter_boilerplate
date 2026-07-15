# build_runner

`2.15.0` · Codegen (dev) · [pub.dev](https://pub.dev/packages/build_runner)

Dart's code-generation runner. Drives all `*.g.dart` generators in this repo: [riverpod_generator](riverpod_generator.md) and [envied_generator](envied_generator.md).

**Where:** dev tooling only; no imports. Triggered by `part 'x.g.dart';` directives.

```sh
dart run build_runner build --delete-conflicting-outputs   # one-off
dart run build_runner watch --delete-conflicting-outputs   # on change
```

**Note:** Run after editing any `@riverpod` or `@Envied` annotation, or `.env`. `--delete-conflicting-outputs` avoids stale-output errors. Generated files are committed.
