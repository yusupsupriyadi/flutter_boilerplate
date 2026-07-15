# http

`1.6.0` · Network · [pub.dev](https://pub.dev/packages/http)

Composable HTTP client. Base of `ApiClient`, which prefixes `baseUrl`, injects a `Bearer` token, logs each request, and throws typed `AppException`s (callers never get `null`).

**Where:** `lib/core/network/api_client.dart`, `app_providers.dart` (`apiClientProvider`, disposes the client).

```dart
Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
  final uri = _uri(path, query);
  try {
    final response = await _client.get(uri, headers: await _headers());
    return _handle(response);
  } on SocketException {
    throw const NetworkException();
  }
}
```

**Note:** `ApiClient` accepts an optional `http.Client?` for test injection. `SocketException` → `NetworkException`; non-2xx → `ApiException`; bad JSON → `ParsingException`. See [flutter-use-http-package](../../.agents/skills/flutter-use-http-package) skill.
