# custom_lint

`0.8.1` · Lint (dev) · [pub.dev](https://pub.dev/packages/custom_lint)

Engine for running third-party lint plugins that the base analyzer can't. Here it hosts [riverpod_lint](riverpod_lint.md).

**Where:** `analysis_options.yaml` (`analyzer.plugins: [custom_lint]`).

```sh
dart run custom_lint
```

**Note:** Required as the host for `riverpod_lint`; without it those rules don't run. Runs separately from `flutter analyze`, though IDEs surface both inline.
