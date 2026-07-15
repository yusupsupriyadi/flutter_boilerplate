# connectivity_plus

`7.2.0` · Network · [pub.dev](https://pub.dev/packages/connectivity_plus)

Reports network connectivity changes. Wrapped to expose a simple `bool` online/offline signal instead of the raw `List<ConnectivityResult>`.

**Where:** `lib/core/network/connectivity_service.dart` (`ConnectivityService`), `app_providers.dart` (`connectivityServiceProvider`, `connectivityStatusProvider` stream), `lib/ui/core/widgets/connectivity_banner.dart`.

```dart
Stream<bool> get onStatusChange =>
    _connectivity.onConnectivityChanged.map(_isOnline);

bool _isOnline(List<ConnectivityResult> results) =>
    results.any((r) => r != ConnectivityResult.none);
```

**Note:** Connectivity indicates a network interface exists, **not** actual internet reachability — a captive portal still reports online. Constructor accepts an optional `Connectivity?` for mocking.
