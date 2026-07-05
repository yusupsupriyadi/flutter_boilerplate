import 'package:connectivity_plus/connectivity_plus.dart';

/// Wraps `connectivity_plus` to expose a simple online/offline signal instead
/// of the raw list of [ConnectivityResult]s.
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  /// Emits `true` when at least one non-`none` connection is available.
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map(_isOnline);

  /// One-shot check of the current connectivity state.
  Future<bool> get isOnline async =>
      _isOnline(await _connectivity.checkConnectivity());

  bool _isOnline(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
