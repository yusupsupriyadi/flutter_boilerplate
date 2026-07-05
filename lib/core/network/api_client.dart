import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../error/app_exception.dart';
import '../logging/app_logger.dart';
import '../storage/secure_storage_service.dart';

/// Minimal REST client built on the `http` package.
///
/// - Prefixes every request path with [baseUrl].
/// - Attaches a `Bearer` token from [secureStorage] when one is stored.
/// - Logs each request/response through [logger].
/// - Throws typed [AppException]s on failure, so callers never receive `null`.
class ApiClient {
  ApiClient({
    required this.baseUrl,
    required this.secureStorage,
    required this.logger,
    http.Client? httpClient,
  }) : _client = httpClient ?? http.Client();

  final String baseUrl;
  final SecureStorageService secureStorage;
  final AppLogger logger;
  final http.Client _client;

  Future<Map<String, String>> _headers() async {
    final token = await secureStorage.readAccessToken();
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      if (token != null && token.isNotEmpty)
        HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final uri = _uri(path, query);
    logger.d('GET $uri');
    try {
      final response = await _client.get(uri, headers: await _headers());
      return _handle(response);
    } on SocketException {
      throw const NetworkException();
    }
  }

  Future<dynamic> post(String path, {Object? body}) async {
    final uri = _uri(path, null);
    logger.d('POST $uri');
    try {
      final response = await _client.post(
        uri,
        headers: await _headers(),
        body: jsonEncode(body),
      );
      return _handle(response);
    } on SocketException {
      throw const NetworkException();
    }
  }

  Uri _uri(String path, Map<String, dynamic>? query) {
    final normalized = path.startsWith('/') ? path : '/$path';
    return Uri.parse(
      '$baseUrl$normalized',
    ).replace(queryParameters: query?.map((k, v) => MapEntry(k, '$v')));
  }

  dynamic _handle(http.Response response) {
    final status = response.statusCode;
    logger.d('<- $status ${response.request?.url}');
    if (status >= 200 && status < 300) {
      if (response.body.isEmpty) return null;
      try {
        return jsonDecode(response.body);
      } on FormatException {
        throw const ParsingException();
      }
    }
    throw ApiException(
      'Request failed (${response.reasonPhrase ?? 'error'}).',
      statusCode: status,
    );
  }

  /// Releases the underlying HTTP client. Called automatically when the
  /// provider is disposed.
  void close() => _client.close();
}
