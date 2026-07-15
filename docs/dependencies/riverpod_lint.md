# riverpod_lint

`3.1.0` · Lint (dev) · [pub.dev](https://pub.dev/packages/riverpod_lint)

Riverpod-specific lint rules and refactoring assists (e.g. missing `keepAlive`, incorrect provider usage, `ref` misuse). Runs on the [custom_lint](custom_lint.md) engine.

**Where:** `analysis_options.yaml` (registered as a `custom_lint` plugin).

```sh
dart run custom_lint      # run the custom-lint plugins
```

**Note:** These rules surface through `custom_lint`, not the base `flutter analyze` set from [flutter_lints](flutter_lints.md). Both `riverpod_lint` and `custom_lint` must be present for the rules to run.
