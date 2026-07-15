# package_rename

`1.10.1` · Native asset (dev) · [pub.dev](https://pub.dev/packages/package_rename)

CLI tool that rewrites app display name and package/bundle identifier across all six platforms (37 fields / 19 files) from one config block. Build-time only — nothing imported at runtime.

**Where:** config in `pubspec.yaml` (`package_rename_config:`) or a root `package_rename_config.yaml`. Use it when rebranding the boilerplate for a new app (app name + `com.example.flutter_boilerplate` → your identifiers).

```yaml
package_rename_config:
  android:
    app_name: "My App"
    package_name: "com.org.app"
    override_old_package: "com.example.flutter_boilerplate" # cleans old folders
  ios:
    app_name: "My App"
    package_name: "com.org.app"
```

```sh
dart run package_rename                       # apply config
dart run package_rename --path="config.yaml"  # custom config path
```

**Note:** Run once after cloning the boilerplate, before shipping. It overwrites native project files — commit first so the diff is reviewable. Set `override_old_package` on Android to remove the old package folder structure. Re-run launcher icons / splash after renaming if identifiers changed.
