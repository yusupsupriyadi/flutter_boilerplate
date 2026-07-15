# envied_generator

`1.3.8` · Codegen (dev) · [pub.dev](https://pub.dev/packages/envied_generator)

Generates the `_Env` class read by [envied](envied.md) `@Envied` annotations, reading `.env` at build time. Run through [build_runner](build_runner.md).

**Where:** produces `lib/core/config/env/env.g.dart` from `env.dart` + `.env`.

```sh
dart run build_runner build --delete-conflicting-outputs
```

**Note:** Requires `.env` to exist (`requireEnvFile: true`) — copy `.env.example` → `.env` first. Regenerate after any `.env` change. Version stays in lockstep with `envied`.
