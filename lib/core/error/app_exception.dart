/// Base type for recoverable application errors surfaced to the UI.
///
/// Services and repositories should throw one of these instead of returning
/// `null`, so callers can pattern-match on the failure.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The device or server could not be reached (no connectivity, timeout, DNS).
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection.']);
}

/// The server responded with a non-success status code.
class ApiException extends AppException {
  const ApiException(super.message, {this.statusCode});

  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// The response body could not be parsed into the expected shape.
class ParsingException extends AppException {
  const ParsingException([super.message = 'Failed to parse server response.']);
}
